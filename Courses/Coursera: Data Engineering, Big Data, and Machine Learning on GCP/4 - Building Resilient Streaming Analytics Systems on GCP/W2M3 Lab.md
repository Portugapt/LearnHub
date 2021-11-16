# Optimizing your BigQuery Queries for Performance 

https://googlecoursera.qwiklabs.com/focuses/17107305


Execute the following query in the BigQuery EDITOR window:

```sql
SELECT
  bike_id,
  duration
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
ORDER BY
  duration DESC
LIMIT
  1
```

In the Query results window notice that the query completed in ~1.2s and processed ~372MB of data.

Execute the following query in the BigQuery EDITOR window:

```sql
SELECT
  *
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
ORDER BY
  duration DESC
LIMIT
  1
  ```

In the Query results window notice that this query completed in ~4.5s and consumed ~2.6GB of data. Much longer!

---

```sql
SELECT
  MIN(start_station_name) AS start_station_name,
  MIN(end_station_name) AS end_station_name,
  APPROX_QUANTILES(duration, 10)[OFFSET (5)] AS typical_duration,
  COUNT(duration) AS num_trips
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
WHERE
  start_station_id != end_station_id
GROUP BY
  start_station_id,
  end_station_id
ORDER BY
  num_trips DESC
LIMIT
  10
  ```

  The details of the query indicate that the sorting (for the approximate quantiles for every station pair) required a repartition of the outputs of the input stage but most of the time is spent during computation.

  We can reduce the I/O overhead of the query if we do the filtering and grouping using the station name rather than the station id since we will need to read fewer columns. Execute the following query:

```sql
SELECT
  start_station_name,
  end_station_name,
  APPROX_QUANTILES(duration, 10)[OFFSET(5)] AS typical_duration,
  COUNT(duration) AS num_trips
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
WHERE
  start_station_name != end_station_name
GROUP BY
  start_station_name,
  end_station_name
ORDER BY
  num_trips DESC
LIMIT
  10
  ```


 ## Reduce number of expensive computations

  Suppose we wish to find the total distance traveled by each bicycle in our dataset.

A naive way to do this would be to find the distance traveled in each trip undertaken by each bicycle and sum them up:

```sql
WITH
  trip_distance AS (
SELECT
  bike_id,
  ST_Distance(ST_GeogPoint(s.longitude,
      s.latitude),
    ST_GeogPoint(e.longitude,
      e.latitude)) AS distance
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire,
  `bigquery-public-data`.london_bicycles.cycle_stations s,
  `bigquery-public-data`.london_bicycles.cycle_stations e
WHERE
  start_station_id = s.id
  AND end_station_id = e.id )
SELECT
  bike_id,
  SUM(distance)/1000 AS total_distance
FROM
  trip_distance
GROUP BY
  bike_id
ORDER BY
  total_distance DESC
LIMIT
  5
```


Computing the distance is a pretty expensive operation and we can avoid joining the cycle_stations table against the cycle_hire table if we precompute the distances between all pairs of stations:

```sql
WITH
  stations AS (
SELECT
  s.id AS start_id,
  e.id AS end_id,
  ST_Distance(ST_GeogPoint(s.longitude,
      s.latitude),
    ST_GeogPoint(e.longitude,
      e.latitude)) AS distance
FROM
  `bigquery-public-data`.london_bicycles.cycle_stations s,
  `bigquery-public-data`.london_bicycles.cycle_stations e ),
trip_distance AS (
SELECT
  bike_id,
  distance
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire,
  stations
WHERE
  start_station_id = start_id
  AND end_station_id = end_id )
SELECT
  bike_id,
  SUM(distance)/1000 AS total_distance
FROM
  trip_distance
GROUP BY
  bike_id
ORDER BY
  total_distance DESC
LIMIT
  5
```

## Avoid self-joins of large tables

Self-joins happen when a table is joined with itself. While BigQuery supports self-joins, they can lead to performance degradation if the table being joined with itself is very large. In many cases, you can avoid the self-join by taking advantage of SQL features such as aggregation and window functions.

```sql
SELECT
  name,
  number AS num_babies
FROM
  `bigquery-public-data`.usa_names.usa_1910_current
WHERE
  gender = 'M' --- and F
  AND year = 2015
  AND state = 'MA'
ORDER BY
  num_babies DESC
LIMIT
  5
```

Self-join:

```sql
WITH
male_babies AS (
SELECT
  name,
  number AS num_babies
FROM
  `bigquery-public-data`.usa_names.usa_1910_current
WHERE
  gender = 'M' ),
female_babies AS (
SELECT
  name,
  number AS num_babies
FROM
  `bigquery-public-data`.usa_names.usa_1910_current
WHERE
  gender = 'F' ),
both_genders AS (
SELECT
  name,
  SUM(m.num_babies) + SUM(f.num_babies) AS num_babies,
  SUM(m.num_babies) / (SUM(m.num_babies) + SUM(f.num_babies)) AS frac_male
FROM
  male_babies AS m
JOIN
  female_babies AS f
USING
  (name)
GROUP BY
  name )
SELECT
  *
FROM
  both_genders
WHERE
  frac_male BETWEEN 0.3
  AND 0.7
ORDER BY
  num_babies DESC
LIMIT
  5
```

To add insult to injury, the answer is also wrong -- as much as we like the name Jordan, the entire US population is only 300 million, so there cannot have been 982 million babies with that name. The self-JOIN unfortunately joins across state and year boundaries.

A faster, more elegant (and correct!) solution is to recast the query to read the input only once and avoid the self-join completely.

```sql
WITH
all_babies AS (
SELECT
  name,
  SUM(
  IF
    (gender = 'M',
      number,
      0)) AS male_babies,
  SUM(
  IF
    (gender = 'F',
      number,
      0)) AS female_babies
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
GROUP BY
  name ),
both_genders AS (
SELECT
  name,
  (male_babies + female_babies) AS num_babies,
  SAFE_DIVIDE(male_babies,
    male_babies + female_babies) AS frac_male
FROM
  all_babies
WHERE
  male_babies > 0
  AND female_babies > 0 )
SELECT
  *
FROM
  both_genders
WHERE
  frac_male BETWEEN 0.3
  AND 0.7
ORDER BY
  num_babies DESC
LIMIT
  5
```

## Using Window function

```sql
SELECT
  bike_id,
  start_date,
  end_date,
  TIMESTAMP_DIFF( start_date, LAG(end_date) OVER (PARTITION BY bike_id ORDER BY start_date), SECOND) AS time_at_station
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
LIMIT
  5
```

```sql
WITH
unused AS (
  SELECT
    bike_id,
    start_station_name,
    start_date,
    end_date,
    TIMESTAMP_DIFF(start_date, LAG(end_date) OVER (PARTITION BY bike_id ORDER BY start_date), SECOND) AS time_at_station
  FROM
    `bigquery-public-data`.london_bicycles.cycle_hire )
SELECT
  start_station_name,
  AVG(time_at_station) AS unused_seconds
FROM
  unused
GROUP BY
  start_station_name
ORDER BY
  unused_seconds ASC
LIMIT
  5
```

---------------
-------------
------------

# Partitioned Tables in Google BigQuery 

https://googlecoursera.qwiklabs.com/focuses/17107726

ecommerce dataset

```sql
#standardSQL
SELECT DISTINCT
  fullVisitorId,
  date,
  city,
  pageTitle
FROM `data-to-insights.ecommerce.all_sessions_raw`
WHERE date = '20170708'
LIMIT 5
```
```sql
#standardSQL
SELECT DISTINCT
  fullVisitorId,
  date,
  city,
  pageTitle
FROM `data-to-insights.ecommerce.all_sessions_raw`
WHERE date = '20180708'
LIMIT 5
```
Notice that the query still processes 1.74 GB even though it returns 0 results. Why? The query engine needs to scan all records in the dataset to see if they satisfy the date matching condition in the WHERE clause. It must look at each record to compare the date against the condition of ‘20180708'.

----
```sql
#standardSQL
 CREATE OR REPLACE TABLE ecommerce.partition_by_day
 PARTITION BY date_formatted
 OPTIONS(
   description="a table partitioned by date"
 ) AS
 SELECT DISTINCT
 PARSE_DATE("%Y%m%d", date) AS date_formatted,
 fullvisitorId
 FROM `data-to-insights.ecommerce.all_sessions_raw`
```

Partitions within partitioned tables on your Qwiklabs account will auto-expire after 60 days from the value in your date column. Your personal GCP account with billing-enabled will let you have partitioned tables that don't expire. For the purposes of this lab, the remaining queries will be ran against partitioned tables that have already been created. 

## Creating an auto-expiring partitioned table

Auto-expiring partitioned tables are used to comply with data privacy statutes, and can be used to avoid unnecessary storage (which you'll be charged for in a production environment). If you want to create a rolling window of data, add an expiration date so the partition disappears after you're finished using it.

```sql
#standardSQL
 SELECT
   DATE(CAST(year AS INT64), CAST(mo AS INT64), CAST(da AS INT64)) AS date,
   (SELECT ANY_VALUE(name) FROM `bigquery-public-data.noaa_gsod.stations` AS stations
    WHERE stations.usaf = stn) AS station_name,  -- Stations may have multiple names
   prcp
 FROM `bigquery-public-data.noaa_gsod.gsod*` AS weather
 WHERE prcp < 99.9  -- Filter unknown values
   AND prcp > 0      -- Filter stations/days with no precipitation
   AND CAST(_TABLE_SUFFIX AS int64) >= 2018
 ORDER BY date DESC -- Where has it rained/snowed recently
 LIMIT 10
```

Modify the previous query to create a table with the below specifications:

* Table name: ecommerce.days_with_rain
* Use the date field as your PARTITION BY
* For OPTIONS, specify partition_expiration_days = 60
* Add the table description = "weather stations with precipitation, partitioned by day"

```sql
#standardSQL
 CREATE OR REPLACE TABLE ecommerce.days_with_rain
 PARTITION BY date
 OPTIONS (
   partition_expiration_days=60,
   description="weather stations with precipitation, partitioned by day"
 ) AS
 SELECT
   DATE(CAST(year AS INT64), CAST(mo AS INT64), CAST(da AS INT64)) AS date,
   (SELECT ANY_VALUE(name) FROM `bigquery-public-data.noaa_gsod.stations` AS stations
    WHERE stations.usaf = stn) AS station_name,  -- Stations may have multiple names
   prcp
 FROM `bigquery-public-data.noaa_gsod.gsod*` AS weather
 WHERE prcp < 99.9  -- Filter unknown values
   AND prcp > 0      -- Filter
   AND CAST(_TABLE_SUFFIX AS int64) >= 2018
```


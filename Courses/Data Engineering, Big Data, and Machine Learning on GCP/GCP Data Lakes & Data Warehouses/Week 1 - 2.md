```sql
WITH bicycle_rentals AS (
  SELECT
    COUNT(starttime) as num_trips,
    EXTRACT(DATE from starttime) as trip_date
  FROM `bigquery-public-data.new_york_citibike.citibike_trips`
  GROUP BY trip_date
),

rainy_days AS
(
SELECT
  date,
  (MAX(prcp) > 5) AS rainy
FROM (
  SELECT
    wx.date AS date,
    IF (wx.element = 'PRCP', wx.value/10, NULL) AS prcp
  FROM
    `bigquery-public-data.ghcn_d.ghcnd_2017` AS wx
  WHERE
    wx.id = 'USW00094728'
)
GROUP BY
  date
)

SELECT
  ROUND(AVG(bk.num_trips)) AS num_trips,
  wx.rainy
FROM bicycle_rentals AS bk
JOIN rainy_days AS wx
ON wx.date = bk.trip_date
GROUP BY wx.rainy
```

Question 1

Which of the following are the jobs of a data engineer? 
- [X] Get the data to where it can be useful
- [X] Get the data into a usable condition
- [x] Add new value to the data
- [X] Manage the data
- [x] Productionize data processes

Question 2

Which statements are true?
 - [X] Cloud SQL is optimized for high-throughput writes
 - [X] BigQuery is optimized for high-read data
 - [ ] BigQuery is a row-based storage
 - [ ] Cloud SQL is optimized for high-read data
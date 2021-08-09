# Predict Bike Trip Duration with a Regression Model in BQML 

qwiklabs-gcp-02-0f4c6e366350

After some EDA,
the query to model is the following

```sql
CREATE OR REPLACE MODEL
  bike_model.model
OPTIONS
  (input_label_cols=['duration'],
    model_type='linear_reg') AS
SELECT
  duration,
  start_station_name,
  CAST(EXTRACT(dayofweek
    FROM
      start_date) AS STRING) AS dayofweek,
  CAST(EXTRACT(hour
    FROM
      start_date) AS STRING) AS hourofday
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
```

Categorizing Weekday and Weekend

```sql
CREATE OR REPLACE MODEL
  bike_model.model_weekday
OPTIONS
  (input_label_cols=['duration'],
    model_type='linear_reg') AS
SELECT
  duration,
  start_station_name,
IF
  (EXTRACT(dayofweek
    FROM
      start_date) BETWEEN 2 AND 6,
    'weekday',
    'weekend') AS dayofweek,
  CAST(EXTRACT(hour
    FROM
      start_date) AS STRING) AS hourofday
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
  ```

Bucketize hour of day

```sql
CREATE OR REPLACE MODEL
  bike_model.model_bucketized
OPTIONS
  (input_label_cols=['duration'],
    model_type='linear_reg') AS
SELECT
  duration,
  start_station_name,
IF
  (EXTRACT(dayofweek
    FROM
      start_date) BETWEEN 2 AND 6,
    'weekday',
    'weekend') AS dayofweek,
  ML.BUCKETIZE(EXTRACT(hour
    FROM
      start_date),
    [5, 10, 17]) AS hourofday
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
```


## Transform

```sql
CREATE OR REPLACE MODEL
  bike_model.model_bucketized TRANSFORM(* EXCEPT(start_date),
  IF
    (EXTRACT(dayofweek
      FROM
        start_date) BETWEEN 2 AND 6,
      'weekday',
      'weekend') AS dayofweek,
    ML.BUCKETIZE(EXTRACT(HOUR
      FROM
        start_date),
      [5, 10, 17]) AS hourofday )
OPTIONS
  (input_label_cols=['duration'],
    model_type='linear_reg') AS
SELECT
  duration,
  start_station_name,
  start_date
FROM
  `bigquery-public-data`.london_bicycles.cycle_hire
```

```sql
SELECT
  *
FROM
  ML.PREDICT(MODEL bike_model.model_bucketized,
    (
    SELECT
      'Park Lane , Hyde Park' AS start_station_name,
      CURRENT_TIMESTAMP() AS start_date) )
```

## Examine model weights

```sql
SELECT * FROM ML.WEIGHTS(MODEL bike_model.model_bucketized)
```

# Movie Recommendations in BigQuery ML


Using Matrix Factorization

Objectives

In this lab, you learn to perform the following tasks:

* Create a BigQuery dataset to store and load MovieLens data

* Explore the MovieLens dataset

* Use a trained model to make recommendations in BigQuery

* Make product predictions for both single users and batch users

## Get Data

```bash
bq --location=EU mk --dataset movies
```

```bash
bq load --source_format=CSV \
 --location=EU \
 --autodetect movies.movielens_ratings \
 gs://dataeng-movielens/ratings.csv

bq load --source_format=CSV \
 --location=EU   \
 --autodetect movies.movielens_movies_raw \
 gs://dataeng-movielens/movies.csv
```

## Explore the data

```sql
SELECT
  COUNT(DISTINCT userId) numUsers,
  COUNT(DISTINCT movieId) numMovies,
  COUNT(*) totalRatings
FROM
  movies.movielens_ratings
```

```sql
SELECT
  *
FROM
  movies.movielens_movies_raw
WHERE
  movieId < 5
```

You can see that the genres column is a formatted string. Parse the genres into an array and rewrite the results into a table named movielens_movies.

```sql
CREATE OR REPLACE TABLE
  movies.movielens_movies AS
SELECT
  * REPLACE(SPLIT(genres, "|") AS genres)
FROM
  movies.movielens_movies_raw
```

## Evaluate a trained model created using collaborative filtering

Matrix factorization is a collaborative filtering technique that relies on two vectors called the user factors and the item factors. The user factors is a low-dimensional representation of a `user_id` and the item factors similarly represents an `item_id`.

Example Query,  **DO NOT RUN** this query.
```sql
 CREATE OR REPLACE MODEL movies.movie_recommender

OPTIONS (model_type='matrix_factorization', user_col='userId', item_col='movieId', rating_col='rating', l2_reg=0.2, num_factors=16) AS

SELECT userId, movieId, rating

FROM movies.movielens_ratings
```

Check results
```sql
SELECT * FROM ML.EVALUATE(MODEL `cloud-training-prod-bucket.movies.movie_recommender`)
```

## Make Recommendations

```sql
SELECT
  *
FROM
  ML.PREDICT(MODEL `cloud-training-prod-bucket.movies.movie_recommender`,
    (
    SELECT
      movieId,
      title,
      903 AS userId
    FROM
      `movies.movielens_movies`,
      UNNEST(genres) g
    WHERE
      g = 'Comedy' ))
ORDER BY
  predicted_rating DESC
LIMIT
  5  
```

Key points for me:
* 903 AS userID
* UNNEST

Remove the movies the iser has already seen:

```sql
SELECT
  *
FROM
  ML.PREDICT(MODEL `cloud-training-prod-bucket.movies.movie_recommender`,
    (
    WITH
      seen AS (
      SELECT
        ARRAY_AGG(movieId) AS movies
      FROM
        movies.movielens_ratings
      WHERE
        userId = 903 )
    SELECT
      movieId,
      title,
      903 AS userId
    FROM
      movies.movielens_movies,
      UNNEST(genres) g,
      seen
    WHERE
      g = 'Comedy'
      AND movieId NOT IN UNNEST(seen.movies) ))
ORDER BY
  predicted_rating DESC
LIMIT
  5
```


## Apply customer targeting

You wish to get more reviews for movieId=96481 which has only one rating and you wish to send coupons to the 100 users who are likely to rate it the highest. Identify those users using:

```sql
SELECT
  *
FROM
  ML.PREDICT(MODEL `cloud-training-prod-bucket.movies.movie_recommender`,
    (
    WITH
      allUsers AS (
      SELECT
        DISTINCT userId
      FROM
        movies.movielens_ratings )
    SELECT
      96481 AS movieId,
      (
      SELECT
        title
      FROM
        movies.movielens_movies
      WHERE
        movieId=96481) title,
      userId
    FROM
      allUsers ))
ORDER BY
  predicted_rating DESC
LIMIT
  100
```

## Perform Batch predictions for all users and movies

```sql
SELECT
  *
FROM
  ML.RECOMMEND(MODEL `cloud-training-prod-bucket.movies.movie_recommender`)
LIMIT 
  100000
```
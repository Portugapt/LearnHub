# Recommendation Engines in PySpark

- [Recommendation Engines in PySpark](#recommendation-engines-in-pyspark)
  - [Types](#types)
  - [Matrix Multiplications](#matrix-multiplications)
  - [Matrix factorization](#matrix-factorization)
  - [Data preparation](#data-preparation)
  - [ALS](#als)
  - [MovieLens Dataset](#movielens-dataset)
  - [Million Songs Dataset](#million-songs-dataset)
  - [ROEM](#roem)


![summary](https://i.imgur.com/owte1GM.png)

## Types

![types1](https://i.imgur.com/wQ29aeV.png)

![types2](https://i.imgur.com/O4S8iPN.png)



## Matrix Multiplications

![matrices](https://i.imgur.com/fiVGTex.png)

## Matrix factorization

![mf1](https://i.imgur.com/rHzSE1P.png)

![mf2](https://i.imgur.com/HvAqbEY.png)

![mf3](https://i.imgur.com/Pt0A1Fu.png)

## Data preparation

![dp1](https://i.imgur.com/do4xtBJ.png)

![dp2](https://i.imgur.com/VOpiaCF.png)

![dp3](https://i.imgur.com/Gc75j9z.png)

```python
# Import monotonically_increasing_id and show R
from pyspark.sql.functions import monotonically_increasing_id
R.show()

# Use the to_long() function to convert the dataframe to the "long" format.
ratings = to_long(R)
ratings.show()

# Get unique users and repartition to 1 partition
users = ratings.select("User").distinct().coalesce(1)

# Create a new column of unique integers called "userId" in the users dataframe.
users = users.withColumn("users", monotonically_increasing_id()).persist()
users.show()
```

```python
# Extract the distinct movie id's
movies = ratings.select("Movie").distinct() 

# Repartition the data to have only one partition.
movies = movies.coalesce(1) 

# Create a new column of movieId integers. 
movies = movies.withColumn("movieId", monotonically_increasing_id()).persist() 

# Join the ratings, users and movies dataframes
movie_ratings = ratings.join(users, "User", "left").join(movies, "Movie", "left")
movie_ratings.show()
```

## ALS

![als1](https://i.imgur.com/IyytMgR.png)

![als2](https://i.imgur.com/jtm5c0f.png)

![als3](https://i.imgur.com/QUQB5KZ.png)

![als4](https://i.imgur.com/E9Cx7Yi.png)

![als5](https://i.imgur.com/sgA3sfL.png)

![als6](https://i.imgur.com/iT4ydvd.png)

![als7](https://i.imgur.com/bTUv7oX.png)

```python
# Split the ratings dataframe into training and test data
(training_data, test_data) = ratings.randomSplit([.8, .2], seed=42)

# Set the ALS hyperparameters
from pyspark.ml.recommendation import ALS
als = ALS(userCol="userId", itemCol="movieId", ratingCol="rating", rank =10, maxIter =15, regParam =.1,
          coldStartStrategy="drop", nonnegative =True, implicitPrefs = False)

# Fit the mdoel to the training_data
model = als.fit(training_data)

# Generate predictions on the test_data
test_predictions = model.transform(test_data)
test_predictions.show()
```

```python
# Import RegressionEvaluator
from pyspark.ml.evaluation import RegressionEvaluator

# Complete the evaluator code
evaluator = RegressionEvaluator(metricName="'rmse'", labelCol="ratings", predictionCol="prediction")

# Extract the 3 parameters
print(evaluator.getMetricName())
print(evaluator.getLabelCol())
print(evaluator.getPredictionCol())
```

## MovieLens Dataset

![movi1](https://i.imgur.com/cz3xy3n.png)

![movi2](https://i.imgur.com/CUroh4T.png)

![movi3](https://i.imgur.com/8tPTB3e.png)

```python
# Count the total number of ratings in the dataset
numerator = ratings.select("rating").count()

# Count the number of distinct userIds and distinct movieIds
num_users = ratings.select("userId").distinct().count()
num_movies = ratings.select("movieId").distinct().count()

# Set the denominator equal to the number of users multiplied by the number of movies
denominator = num_users * num_movies

# Divide the numerator by the denominator
sparsity = (1.0 - (numerator *1.0)/denominator)*100
print("The ratings dataframe is ", "%.2f" % sparsity + "% empty.")
```

```python
# Import the requisite packages
from pyspark.sql.functions import col

# View the ratings dataset
ratings.show()

# Filter to show only userIds less than 100
ratings.filter(col("userId") < 100).show()

# Group data by userId, count ratings
ratings.groupBy("userId").count().show()
```

```python
# Min num ratings for movies
print("Movie with the fewest ratings: ")
ratings.groupBy("movieId").count().select(min("count")).show()

# Avg num ratings per movie
print("Avg num ratings per movie: ")
ratings.groupBy("movieId").count().select(avg("count")).show()

# Min num ratings for user
print("User with the fewest ratings: ")
ratings.groupBy("userId").count().select(min("count")).show()

# Avg num ratings per users
print("Avg num ratings per user: ")
ratings.groupBy("userId").count().select(avg("count")).show()
```

```console
<script.py> output:
    Movie with the fewest ratings: 
    +----------+
    |min(count)|
    +----------+
    |         1|
    +----------+
    
    Avg num ratings per movie: 
    +------------------+
    |        avg(count)|
    +------------------+
    |11.030664019413193|
    +------------------+
    
    User with the fewest ratings: 
    +----------+
    |min(count)|
    +----------+
    |        20|
    +----------+
    
    Avg num ratings per user: 
    +------------------+
    |        avg(count)|
    +------------------+
    |149.03725782414307|
    +------------------+
```

Users have at least 20 ratings and on average of 149 ratings. And movies have at least 1 rating with an average of 11 ratings.

```python
# Use .printSchema() to see the datatypes of the ratings dataset
ratings.printSchema()

# Tell Spark to convert the columns to the proper data types
ratings = ratings.select(ratings.userId.cast("integer"), ratings.movieId.cast("integer"), ratings.rating.cast("double"))

# Call .printSchema() again to confirm the columns are now in the correct format
ratings.printSchema()
```

![basicmodel](https://i.imgur.com/16zMubN.png)

![performanceevaluation](https://i.imgur.com/3tJzF6E.png)

```python
# Import the required functions
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.ml.recommendation import ALS
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator

# Create test and train set
(train, test) = ratings.randomSplit([0.8, 0.2], seed = 1234)

# Create ALS model
als = ALS(userCol="userId", itemCol="movieId", ratingCol="rating", nonnegative = True, implicitPrefs = False, coldStartStrategy = 'drop')

# Confirm that a model called "als" was created
type(als)

# Add hyperparameters and their respective values to param_grid
param_grid = ParamGridBuilder() \
            .addGrid(als.rank, [10, 50, 100, 150]  ) \
            .addGrid(als.maxIter, [5, 50, 100, 200]) \
            .addGrid(als.regParam, [.01, .05, .1, .15]) \
            .build()
           
# Define evaluator as RMSE and print length of evaluator
evaluator = RegressionEvaluator(metricName="rmse", labelCol="rating", predictionCol="prediction") 
print ("Num models to be tested: ", len(param_grid))

# Build cross validation using CrossValidator
cv = CrossValidator(estimator=als, estimatorParamMaps=param_grid, evaluator=evaluator, numFolds=5)

# Confirm cv was built
print(cv)

# Print best_model
print(type(best_model))

# Complete the code below to extract the ALS model parameters
print("**Best Model**")

# Print "Rank"
print("  Rank:", best_model.getRank())

# Print "MaxIter"
print("  MaxIter:", best_model.getMaxIter())

# Print "RegParam"
print("  RegParam:", best_model.getRegParam())
```

![rmse44](https://i.imgur.com/HBFuvzr.png)

![cleanoutput](https://i.imgur.com/WSlFFYx.png)

![explode](https://i.imgur.com/wlrJahj.png)

![combined](https://i.imgur.com/1LvJYHP.png)

RMSE

```python
# View the predictions 
test_predictions.show()

# Calculate and print the RMSE of test_predictions
RMSE = evaluator.evaluate(test_predictions)
print(RMSE)
```

```python
# Look at user 60's ratings
print("User 60's Ratings:")
original_ratings.filter(col("userId") == 60).sort("rating", ascending = False).show()

# Look at the movies recommended to user 60
print("User 60s Recommendations:")
recommendations.filter(col("userId") == 60).show()

# Look at user 63's ratings
print("User 63's Ratings:")
original_ratings.filter(col("userId") == 63).sort("rating", ascending = False).show()

# Look at the movies recommended to user 63
print("User 63's Recommendations:")
recommendations.filter(col("userId") == 63).show()
```

## Million Songs Dataset

![fillna](https://i.imgur.com/vK9Yn4L.png)

![func1](https://i.imgur.com/lcM1Uyu.png)

```python
# Min num implicit ratings for a song
print("Minimum implicit ratings for a song: ")
msd.filter(col("num_plays") > 0).groupBy("songId").count().select(min("count")).show()

# Avg num implicit ratings per songs
print("Average implicit ratings per song: ")
msd.filter(col("num_plays") > 0).groupBy("songId").count().select(avg("count")).show()

# Min num implicit ratings from a user
print("Minimum implicit ratings from a user: ")
msd.filter(col("num_plays") > 0).groupBy("userId").count().select(min("count")).show()

# Avg num implicit ratings for users
print("Average implicit ratings per user: ")
msd.filter(col("num_plays") > 0).groupBy("userId").count().select(avg("count")).show()
```

```python
# View the data
Z.show()

# Extract distinct userIds and productIds
users = Z.select("userId").distinct()
products = Z.select("productId").distinct()

# Cross join users and products
cj = users.crossJoin(products)

# Join cj and Z
Z_expanded = cj.join(Z, ["userId", "productId"], "left").fillna(0)

# View Z_expanded
Z_expanded.show()
```

## ROEM

Bad predictions:  

![roem1](https://i.imgur.com/efcGOhu.png)

![roem2](https://i.imgur.com/t1JnEeg.png)

![roem3](https://i.imgur.com/cFDyZKo.png)

Good Predictions:  

![roem4](https://i.imgur.com/iNBp4K9.png)

![roem5](https://i.imgur.com/Y27STuS.png)

![roem6](https://i.imgur.com/4JNJ7cD.png)

![roem7](https://i.imgur.com/o7yFGC9.png)

```python
# For loop will automatically create and store ALS models
for r in ranks:
    for mi in maxIters:
        for rp in regParams:
            for a in alphas:
                model_list.append(ALS(userCol= "userId", itemCol= "songId", ratingCol= "num_plays", rank = r, maxIter = mi, regParam = rp, alpha = a, coldStartStrategy="drop", nonnegative = True, implicitPrefs = True))

# Print the model list, and the length of model_list
print (model_list, "\nLength of model_list: ", len(model_list))

# Validate
len(model_list) == (len(ranks)*len(maxIters)*len(regParams)*len(alphas))
```

```python
# Split the data into training and test sets
(training, test) = msd.randomSplit([0.8, 0.2])

#Building 5 folds within the training set.
train1, train2, train3, train4, train5 = training.randomSplit([0.2, 0.2, 0.2, 0.2, 0.2], seed = 1)
fold1 = train2.union(train3).union(train4).union(train5)
fold2 = train3.union(train4).union(train5).union(train1)
fold3 = train4.union(train5).union(train1).union(train2)
fold4 = train5.union(train1).union(train2).union(train3)
fold5 = train1.union(train2).union(train3).union(train4)

foldlist = [(fold1, train1), (fold2, train2), (fold3, train3), (fold4, train4), (fold5, train5)]

# Empty list to fill with ROEMs from each model
ROEMS = []

# Loops through all models and all folds
for model in model_list:
    for ft_pair in foldlist:

        # Fits model to fold within training data
        fitted_model = model.fit(ft_pair[0])

        # Generates predictions using fitted_model on respective CV test data
        predictions = fitted_model.transform(ft_pair[1])

        # Generates and prints a ROEM metric CV test data
        r = ROEM(predictions)
        print ("ROEM: ", r)

    # Fits model to all of training data and generates preds for test data
    v_fitted_model = model.fit(training)
    v_predictions = v_fitted_model.transform(test)
    v_ROEM = ROEM(v_predictions)

    # Adds validation ROEM to ROEM list
    ROEMS.append(v_ROEM)
    print ("Validation ROEM: ", v_ROEM)
```

```python
# Import numpy
import numpy

# Find the index of the smallest ROEM
i = numpy.argmin(ROEMS)
print("Index of smallest ROEM:", i)

# Find ith element of ROEMS
print("Smallest ROEM: ", ROEMS[i])
# model index 38
```

```python
# Extract the best_model
best_model = model_list[38]

# Extract the Rank
print ("Rank: ", best_model.getRank())

# Extract the MaxIter value
print ("MaxIter: ", best_model.getMaxIter())

# Extract the RegParam value
print ("RegParam: ", best_model.getRegParam())

# Extract the Alpha value
print ("Alpha: ", best_model.getAlpha())
```

```python
# Import the col function
from pyspark.sql.functions import col

# Look at the test predictions
binary_test_predictions.show()

# Evaluate ROEM on test predictions
ROEM(binary_test_predictions)

# Look at user 42's test predictions
binary_test_predictions.filter(col("userId") == 42).show()
```
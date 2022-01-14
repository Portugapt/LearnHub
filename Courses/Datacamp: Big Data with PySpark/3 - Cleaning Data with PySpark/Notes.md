# Cleaning Data with PySpark

- [Cleaning Data with PySpark](#cleaning-data-with-pyspark)
  - [Schema](#schema)
  - [Lazy Processing](#lazy-processing)
  - [Parquet](#parquet)
  - [Filters and Transforms](#filters-and-transforms)
  - [Conditional Transformations](#conditional-transformations)
    - [.when and .otherwise](#when-and-otherwise)
  - [UDF's](#udfs)
  - [Monotonic ID's](#monotonic-ids)
  - [Caching](#caching)
  - [import performance (Clusters)](#import-performance-clusters)
  - [Clusters](#clusters)
  - [Shuffling & Broadcast](#shuffling--broadcast)
  - [Data pipelines](#data-pipelines)
  - [Data handling](#data-handling)
  - [Validation](#validation)
  - [Analysis calculations](#analysis-calculations)
    - [create udf for total pixels of dogs and filter only photos with 60% more of photo has dog.](#create-udf-for-total-pixels-of-dogs-and-filter-only-photos-with-60-more-of-photo-has-dog)

## Schema

![schema1](https://i.imgur.com/7CBq8II.png)

![schema2](https://i.imgur.com/nTJ36OU.png)

```python
# Import the pyspark.sql.types library
from pyspark.sql.types import *

# Define a new schema using the StructType method
people_schema = StructType([
  # Define a StructField for each field
  StructField('name', StringType(), False),
  StructField('age', IntegerType(), False),
  StructField('city', StringType(), False)
])
```

## Lazy Processing

Very little happens until an action is performed. Transformations are just a change in the instructions. After an action is done, the actual changes are performed.

![lp1](https://i.imgur.com/DBX61oI.png)

```python
# Load the CSV file
aa_dfw_df = spark.read.format('csv').options(Header=True).load('AA_DFW_2018.csv.gz')

# Add the airport column using the F.lower() method
aa_dfw_df = aa_dfw_df.withColumn('airport', F.lower(aa_dfw_df['Destination Airport']))

# Drop the Destination Airport column
aa_dfw_df = aa_dfw_df.drop(aa_dfw_df['Destination Airport'])

# Show the DataFrame
aa_dfw_df.show()
```

## Parquet

In addition to the issues with CSV files in general, Spark has some specific problems processing CSV data. CSV files are quite slow to import and parse. The files cannot be shared between workers during the import process. If no schema is defined, all data must be read before a schema can be inferred. Spark has feature known as predicate pushdown. Basically, this is the idea of ordering tasks to do the least amount of work. Filtering data prior to processing is one of the primary optimizations of predicate pushdown. This drastically reduces the amount of information that must be processed in large data sets. Unfortunately, you cannot filter the CSV data via predicate pushdown. Finally, Spark processes are often multi-step and may utilize an intermediate file representation. These representations allow data to be used later without regenerating the data from source. Using CSV would instead require a significant amount of extra work defining schemas, encoding formats, etc.

![parquet1](https://i.imgur.com/OuI7idg.png)

![parquet2](https://i.imgur.com/YCRWDlm.png)

 Because we're using Parquet as the backing store, we get all the performance benefits we've discussed previously (primarily defined schemas and the available use of predicate pushdown). 

Allowing Spark to use predicate pushdown. This means Spark will only process the data necessary to complete the operations you define versus reading the entire dataset.

```python
# View the row count of df1 and df2
print("df1 Count: %d" % df1.count())
print("df2 Count: %d" % df2.count())

# Combine the DataFrames into one
df3 = df1.union(df2)

# Save the df3 DataFrame in Parquet format
df3.write.parquet('AA_DFW_ALL.parquet', mode='overwrite')

# Read the Parquet file into a new DataFrame and run a count
print(spark.read.parquet('AA_DFW_ALL.parquet').count())
```

## Filters and Transforms

```python
# Read the Parquet file into flights_df
flights_df = spark.read.parquet('AA_DFW_ALL.parquet')

# Register the temp table
flights_df.createOrReplaceTempView('flights')

# Run a SQL query of the average flight duration
avg_duration = spark.sql('SELECT avg(flight_duration) from flights').collect()[0]
print('The average flight time is: %d' % avg_duration)
```

```python
# Show the distinct VOTER_NAME entries
voter_df.select(voter_df.VOTER_NAME).distinct().show(40, truncate=False)

# Filter voter_df where the VOTER_NAME is 1-20 characters in length
voter_df = voter_df.filter('length(VOTER_NAME) > 0 and length(VOTER_NAME) < 20')

# Filter out voter_df where the VOTER_NAME contains an underscore
voter_df = voter_df.filter(~ F.col('VOTER_NAME').contains('_'))

# Show the distinct VOTER_NAME entries again
voter_df.select(voter_df.VOTER_NAME).distinct().show(40, truncate=False)
```

```python
# Add a new column called splits separated on whitespace
voter_df = voter_df.withColumn('splits', F.split(voter_df.VOTER_NAME, '\s+'))

# Create a new column called first_name based on the first item in splits
voter_df = voter_df.withColumn('first_name', voter_df.splits.getItem(0))

# Get the last entry of the splits list and create a column called last_name
voter_df = voter_df.withColumn('last_name', voter_df.splits.getItem(F.size('splits') - 1))

# Drop the splits column
voter_df = voter_df.drop('splits')

# Show the voter_df DataFrame
voter_df.show()
```

## Conditional Transformations

### .when and .otherwise

![when1](https://i.imgur.com/UUbX44g.png)

![otherwise1](https://i.imgur.com/13Y7nfZ.png)

```python
# Add a column to voter_df for any voter with the title **Councilmember**
voter_df = voter_df.withColumn('random_val',
                               when(voter_df.TITLE == 'Councilmember', F.rand()))

# Show some of the DataFrame rows, noting whether the when clause worked
voter_df.show()
```

```python
# Add a column to voter_df for a voter based on their position
voter_df = voter_df.withColumn('random_val',
                               when(voter_df.TITLE == 'Councilmember', F.rand())
                               .when(voter_df.TITLE == 'Mayor', 2)
                               .otherwise(0))

# Show some of the DataFrame rows
voter_df.show()

# Use the .filter() clause with random_val
voter_df.filter(voter_df.random_val == 0).show()
```

## UDF's

![udf1](https://i.imgur.com/AifAdY9.png)

The next step is to wrap the function and store it in a variable for later use. We'll use the pyspark.sql.functions.udf() method. It takes two arguments - the name of the method you just defined, and the Spark data type it will return. This can be any of the options in pyspark.sql.types, and can even be a more complex type, including a fully defined schema object. Most often, you'll return either a simple object type, or perhaps an ArrayType. 

![udf2](https://i.imgur.com/nrKqYyb.png)

![udf3](https://i.imgur.com/0f3Y5ub.png)

```python
def getFirstAndMiddle(names):
  # Return a space separated string of names
  return ' '.join(names)

# Define the method as a UDF
udfFirstAndMiddle = F.udf(getFirstAndMiddle, StringType())

# Create a new column using your UDF
voter_df = voter_df.withColumn('first_and_middle_name', udfFirstAndMiddle(voter_df.splits))

# Show the DataFrame
voter_df.show()
```

## Monotonic ID's

![ids1](https://i.imgur.com/0VI5WCA.png)

```python
# Select all the unique council voters
voter_df = df.select(df["VOTER NAME"]).distinct()

# Count the rows in voter_df
print("\nThere are %d rows in the voter_df DataFrame.\n" % voter_df.count())

# Add a ROW_ID
voter_df = voter_df.withColumn('ROW_ID', F.monotonically_increasing_id())

# Show the rows with 10 highest IDs in the set
voter_df.orderBy(voter_df.ROW_ID.desc()).show(10)
```

```python
# Print the number of partitions in each DataFrame
print("\nThere are %d partitions in the voter_df DataFrame.\n" % voter_df.rdd.getNumPartitions())
print("\nThere are %d partitions in the voter_df_single DataFrame.\n" % voter_df_single.rdd.getNumPartitions())

# Add a ROW_ID field to each DataFrame
voter_df = voter_df.withColumn('ROW_ID', F.monotonically_increasing_id())
voter_df_single = voter_df_single.withColumn('ROW_ID', F.monotonically_increasing_id())

# Show the top 10 IDs in each DataFrame 
voter_df.orderBy(voter_df.ROW_ID.desc()).show(10)
voter_df_single.orderBy(voter_df_single.ROW_ID.desc()).show(10)
```

```console
<script.py> output:
    
    There are 200 partitions in the voter_df DataFrame.
    
    
    There are 1 partitions in the voter_df_single DataFrame.
    
    +--------------------+-------------+
    |          VOTER NAME|       ROW_ID|
    +--------------------+-------------+
    |        Lee Kleinman|1709396983808|
    |  the  final  201...|1700807049217|
    |         Erik Wilson|1700807049216|
    |  the  final   20...|1683627180032|
    | Carolyn King Arnold|1632087572480|
    | Rickey D.  Callahan|1597727834112|
    |   the   final  2...|1443109011456|
    |    Monica R. Alonzo|1382979469312|
    |     Lee M. Kleinman|1228360646656|
    |   Jennifer S. Gates|1194000908288|
    +--------------------+-------------+
    only showing top 10 rows
    
    +--------------------+------+
    |          VOTER NAME|ROW_ID|
    +--------------------+------+
    |        Lee Kleinman|    35|
    |  the  final  201...|    34|
    |         Erik Wilson|    33|
    |  the  final   20...|    32|
    | Carolyn King Arnold|    31|
    | Rickey D.  Callahan|    30|
    |   the   final  2...|    29|
    |    Monica R. Alonzo|    28|
    |     Lee M. Kleinman|    27|
    |   Jennifer S. Gates|    26|
    +--------------------+------+
    only showing top 10 rows
```

```python
# Determine the highest ROW_ID and save it in previous_max_ID
previous_max_ID = voter_df_march.select('ROW_ID').rdd.max()[0]

# Add a ROW_ID column to voter_df_april starting at the desired value
voter_df_april = voter_df_april.withColumn('ROW_ID', previous_max_ID + F.monotonically_increasing_id())

# Show the ROW_ID from both DataFrames and compare
voter_df_march.select('ROW_ID').show()
voter_df_april.select('ROW_ID').show()
```

## Caching

Adding cache:  

```python
start_time = time.time()

# Add caching to the unique rows in departures_df
departures_df = departures_df.distinct().cache()

# Count the unique rows in departures_df, noting how long the operation takes
print("Counting %d rows took %f seconds" % (departures_df.count(), time.time() - start_time))

# Count the rows again, noting the variance in time of a cached DataFrame
start_time = time.time()
print("Counting %d rows again took %f seconds" % (departures_df.count(), time.time() - start_time))
```

Removing Cache:

```python
# Determine if departures_df is in the cache
print("Is departures_df cached?: %s" % departures_df.is_cached)
print("Removing departures_df from cache")

# Remove departures_df from the cache
departures_df.unpersist()

# Check the cache status again
print("Is departures_df cached?: %s" % departures_df.is_cached)
```

## import performance (Clusters)

Spark clusters consist of two types of processes - one driver process and as many worker processes as required. The driver handles task assignments and consolidation of the data results from the workers. The workers typically handle the actual transformation / action tasks of a Spark job. Once assigned tasks, they operate fairly independently and report results back to the driver. It is possible to have a single node Spark cluster (this is what we're using for this course) but you'll rarely see this in a production environment. 

![sc1](https://i.imgur.com/zNQI8IZ.pngs)

![ip1](https://i.imgur.com/FBaAQcY.png)

![schemas1](https://i.imgur.com/YUzOE4c.png)

![parquet2](https://i.imgur.com/X0AWc6K.png)

## Clusters

![cluster1](https://i.imgur.com/fGwfmG0.png)

![cluster2](https://i.imgur.com/viYA5M7.png)

![cluster4](https://i.imgur.com/acWkimK.png)

![cluster3](https://i.imgur.com/brudPAk.png)

```python
# Name of the Spark application instance
app_name = spark.conf.get('spark.app.name')

# Driver TCP port
driver_tcp_port = spark.conf.get('spark.driver.port')

# Number of join partitions
num_partitions = spark.conf.get('spark.sql.shuffle.partitions')

# Show the results
print("Name: %s" % app_name)
print("Driver TCP port: %s" % driver_tcp_port)
print("Number of partitions: %s" % num_partitions)
```

```python
# Store the number of partitions in variable
before = departures_df.rdd.getNumPartitions()

# Configure Spark to use 500 partitions
spark.conf.set('spark.sql.shuffle.partitions', 500)

# Recreate the DataFrame using the departures data file
departures_df = spark.read.csv('departures.txt.gz').distinct()

# Print the number of partitions for each instance
print("Partition count before change: %d" % before)
print("Partition count after change: %d" % departures_df.rdd.getNumPartitions())    
```

## Shuffling & Broadcast

![shuffling](https://i.imgur.com/las4Tq7.png)

![shuffling2](https://i.imgur.com/cKNV5vt.png)

![shuffling3](https://i.imgur.com/FRW4Lr1.png)

https://medium.com/the-code-shelf/spark-query-plans-for-dummies-6f3733bab146

```python
# Join the flights_df and aiports_df DataFrames
normal_df = flights_df.join(airports_df, \
    flights_df["Destination Airport"] == airports_df["IATA"] )

# Show the query plan
normal_df.explain()
```

```console
<script.py> output:
    == Physical Plan ==
    *(5) SortMergeJoin [Destination Airport#12], [IATA#29], Inner
    :- *(2) Sort [Destination Airport#12 ASC NULLS FIRST], false, 0
    :  +- Exchange hashpartitioning(Destination Airport#12, 200)
    :     +- *(1) Project [Date (MM/DD/YYYY)#10, Flight Number#11, Destination Airport#12, Actual elapsed time (Minutes)#13]
    :        +- *(1) Filter isnotnull(Destination Airport#12)
    :           +- *(1) FileScan csv [Date (MM/DD/YYYY)#10,Flight Number#11,Destination Airport#12,Actual elapsed time (Minutes)#13] Batched: false, Format: CSV, Location: InMemoryFileIndex[file:/tmp/tmpsyzegaq3/AA_DFW_2018_Departures_Short.csv.gz], PartitionFilters: [], PushedFilters: [IsNotNull(Destination Airport)], ReadSchema: struct<Date (MM/DD/YYYY):string,Flight Number:string,Destination Airport:string,Actual elapsed ti...
    +- *(4) Sort [IATA#29 ASC NULLS FIRST], false, 0
       +- Exchange hashpartitioning(IATA#29, 200)
          +- *(3) Project [AIRPORTNAME#28, IATA#29]
             +- *(3) Filter isnotnull(IATA#29)
                +- *(3) FileScan csv [AIRPORTNAME#28,IATA#29] Batched: false, Format: CSV, Location: InMemoryFileIndex[file:/tmp/tmpsyzegaq3/airportnames.txt.gz], PartitionFilters: [], PushedFilters: [IsNotNull(IATA)], ReadSchema: struct<AIRPORTNAME:string,IATA:string>

```

```python
# Import the broadcast method from pyspark.sql.functions
from pyspark.sql.functions import broadcast

# Join the flights_df and airports_df DataFrames using broadcasting
broadcast_df = flights_df.join(broadcast(airports_df), \
    flights_df["Destination Airport"] == airports_df["IATA"] )

# Show the query plan and compare against the original
broadcast_df.explain()
```

```console
<script.py> output:
    == Physical Plan ==
    *(2) BroadcastHashJoin [Destination Airport#12], [IATA#29], Inner, BuildRight
    :- *(2) Project [Date (MM/DD/YYYY)#10, Flight Number#11, Destination Airport#12, Actual elapsed time (Minutes)#13]
    :  +- *(2) Filter isnotnull(Destination Airport#12)
    :     +- *(2) FileScan csv [Date (MM/DD/YYYY)#10,Flight Number#11,Destination Airport#12,Actual elapsed time (Minutes)#13] Batched: false, Format: CSV, Location: InMemoryFileIndex[file:/tmp/tmp4kgsf8ua/AA_DFW_2018_Departures_Short.csv.gz], PartitionFilters: [], PushedFilters: [IsNotNull(Destination Airport)], ReadSchema: struct<Date (MM/DD/YYYY):string,Flight Number:string,Destination Airport:string,Actual elapsed ti...
    +- BroadcastExchange HashedRelationBroadcastMode(List(input[1, string, true]))
       +- *(1) Project [AIRPORTNAME#28, IATA#29]
          +- *(1) Filter isnotnull(IATA#29)
             +- *(1) FileScan csv [AIRPORTNAME#28,IATA#29] Batched: false, Format: CSV, Location: InMemoryFileIndex[file:/tmp/tmp4kgsf8ua/airportnames.txt.gz], PartitionFilters: [], PushedFilters: [IsNotNull(IATA)], ReadSchema: struct<AIRPORTNAME:string,IATA:string>

```

```python
start_time = time.time()
# Count the number of rows in the normal DataFrame
normal_count = normal_df.count()
normal_duration = time.time() - start_time

start_time = time.time()
# Count the number of rows in the broadcast DataFrame
broadcast_count = broadcast_df.count()
broadcast_duration = time.time() - start_time

# Print the counts and the duration of the tests
print("Normal count:\t\t%d\tduration: %f" % (normal_count, normal_duration))
print("Broadcast count:\t%d\tduration: %f" % (broadcast_count, broadcast_duration))
```

## Data pipelines

![pipes1](https://i.imgur.com/1f072Lr.png)

![pipes2](https://i.imgur.com/Gm5pYrM.png)

```python
# Import the data to a DataFrame
departures_df = spark.read.csv('2015-departures.csv.gz', header=True)

# Remove any duration of 0
departures_df = departures_df.filter(departures_df[3] > 0)

# Add an ID column
departures_df = departures_df.withColumn('id', F.monotonically_increasing_id())

# Write the file out to JSON format
departures_df.write.json('output.json', mode='overwrite')
```

## Data handling

```python
# Import the file to a DataFrame and perform a row count
annotations_df = spark.read.csv('annotations.csv.gz', sep='|')
full_count = annotations_df.count()

# Count the number of rows beginning with '#'
comment_count = annotations_df.where(col('_c0').startswith('#')).count()

# Import the file to a new DataFrame, without commented rows
no_comments_df = spark.read.csv('annotations.csv.gz', sep='|', comment='#')

# Count the new DataFrame and verify the difference is as expected
no_comments_count = no_comments_df.count()
print("Full count: %d\nComment count: %d\nRemaining count: %d" % (full_count, comment_count, no_comments_count))
```

```python
# Split _c0 on the tab character and store the list in a variable
tmp_fields = F.split(annotations_df['_c0'], '\t')

# Create the colcount column on the DataFrame
annotations_df = annotations_df.withColumn('colcount', F.size(tmp_fields))

# Remove any rows containing fewer than 5 fields
annotations_df_filtered = annotations_df.filter(~ (annotations_df["colcount"] < 5))

# Count the number of rows
final_count = annotations_df_filtered.count()
print("Initial count: %d\nFinal count: %d" % (initial_count, final_count))
```

```python
# Split the content of _c0 on the tab character (aka, '\t')
split_cols = F.split(annotations_df['_c0'], '\t')

# Add the columns folder, filename, width, and height
split_df = annotations_df.withColumn('folder', split_cols.getItem(0))
split_df = split_df.withColumn('filename', split_cols.getItem(1))
split_df = split_df.withColumn('width', split_cols.getItem(2))
split_df = split_df.withColumn('height', split_cols.getItem(3))

# Add split_cols as a column
split_df = split_df.withColumn('split_cols', split_cols)

def retriever(cols, colcount):
  # Return a list of dog data
  return cols[4:colcount]

# Define the method as a UDF
udfRetriever = F.udf(retriever, ArrayType(StringType()))

# Create a new column using your UDF
split_df = split_df.withColumn('dog_list', udfRetriever(split_df.split_cols, split_df.colcount))

# Remove the original column, split_cols, and the colcount
split_df = split_df.drop('split_cols').drop('colcount').drop('_c0')
```

## Validation

![val1](https://i.imgur.com/7CbgT8y.png)

![val2](https://i.imgur.com/v4yNOcM.png)

![val3](https://i.imgur.com/KuFRlPd.png)

```python
# Rename the column in valid_folders_df
valid_folders_df = valid_folders_df.withColumnRenamed('_c0', 'folder')

# Count the number of rows in split_df
split_count = split_df.count()

# Join the DataFrames
joined_df = split_df.join(F.broadcast(valid_folders_df), "folder")

# Compare the number of rows remaining
joined_count = joined_df.count()
print("Before: %d\nAfter: %d" % (split_count, joined_count))

# Determine the row counts for each DataFrame
split_count = split_df.count()
joined_count = joined_df.count()

# Create a DataFrame containing the invalid rows
invalid_df = split_df.join(F.broadcast(joined_df), 'folder', 'outer')

# Validate the count of the new DataFrame is as expected
invalid_count = invalid_df.count()
print(" split_df:\t%d\n joined_df:\t%d\n invalid_df: \t%d" % (split_count, joined_count, invalid_count))

# Determine the number of distinct folder rows removed
invalid_folder_count = invalid_df.select('folder').distinct().count()
print("%d distinct invalid folders found" % invalid_folder_count)
```

## Analysis calculations

![ac1](https://i.imgur.com/1d9oKEB.png)

![ac2](https://i.imgur.com/bTQ38nc.png)

```python
# Select the dog details and show 10 untruncated rows
print(joined_df.select('dog_list').show(10, truncate=False))

# Define a schema type for the details in the dog list
DogType = StructType([
	StructField("breed", StringType(), False),
    StructField("start_x", IntegerType(), False),
    StructField("start_y", IntegerType(), False),
    StructField("end_x", IntegerType(), False),
    StructField("end_y", IntegerType(), False)
])
```

https://stackoverflow.com/questions/50947780/arraytype-of-mixed-data-in-spark

https://spark.apache.org/docs/3.0.0-preview2/sql-ref-datatypes.html

```python
# Create a function to return the number and type of dogs as a tuple
def dogParse(doglist):
  dogs = []
  for dog in doglist:
    (breed, start_x, start_y, end_x, end_y) = dog.split(',')
    dogs.append((breed, int(start_x), int(start_y), int(end_x), int(end_y)))
  return dogs

# Create a UDF
udfDogParse = F.udf(dogParse, ArrayType(DogType))

# Use the UDF to list of dogs and drop the old column
joined_df = joined_df.withColumn('dogs', udfDogParse('dog_list')).drop('dog_list')

# Show the number of dogs in the first 10 rows
joined_df.select(F.size('dogs')).show(10)   
```

### create udf for total pixels of dogs and filter only photos with 60% more of photo has dog.

```python
# Define a UDF to determine the number of pixels per image
def dogPixelCount(doglist):
  totalpixels = 0
  for dog in doglist:
    totalpixels += (dog[3] - dog[1]) * (dog[4] - dog[2])
  return totalpixels

# Define a UDF for the pixel count
udfDogPixelCount = F.udf(dogPixelCount, IntegerType())
joined_df = joined_df.withColumn('dog_pixels', udfDogPixelCount('dogs'))

# Create a column representing the percentage of pixels
joined_df = joined_df.withColumn('dog_percent', (joined_df.dog_pixels / (joined_df.width*joined_df.height)) * 100)

# Show the first 10 annotations with more than 60% dog
joined_df.where(joined_df.dog_percent > 60).show(10)
```
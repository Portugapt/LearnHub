



## BigQuery

bq mk taxirides

bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime

ou

ride_id:string,
point_idx:integer,
latitude:float,
longitude:float,
timestamp:timestamp,
meter_reading:float,
meter_increment:float,
ride_status:string,
passenger_count:integer

## Cloud Storage

create cloud storage bucket


## Dataflow

streaming-taxi-pipeline


It has REST or Command line equivalent button.
Check it out next time



Relational databases are a good choice when you need:
Transitional Data on small datasets

Question 2

Cloud SQL and Cloud Dataproc offer familiar tools (MySQL and Hadoop/Pig/Hive/Spark). What is the value-add provided by Google Cloud Platform?

- [ ] It’s the same API, but Google implements it better.  
- [ ] Google-proprietary extensions and bug fixes to MySQL, Hadoop, and so on.  
- [X] Fully-managed versions of the software offer no-ops.  
- [X] Running it on Google infrastructure offers reliability and cost savings


## AutoML Vision

gs://qwiklabs-gcp-02-21199c9349ec-vcm/data.csv
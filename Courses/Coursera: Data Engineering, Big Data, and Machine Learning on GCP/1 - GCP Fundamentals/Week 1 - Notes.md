# [Notes on  GCP Big Data Fundamentals](https://www.coursera.org/learn/gcp-big-data-ml-fundamentals/home/welcome)
- [Notes on  GCP Big Data Fundamentals](#notes-on--gcp-big-data-fundamentals)
  - [Notes](#notes)
  - [How to create a VM and dataset](#how-to-create-a-vm-and-dataset)
  - [Keywords](#keywords)
  - [First Module Review](#first-module-review)
  - [## Module Review](#-module-review)
  - [- data,  rules](#--data--rules)
  - [* False](#-false)
  - [* False](#-false-1)
  - [* Consider having multiple Cloud Dataproc instances for each priority workload and then turning them down when not in use](#-consider-having-multiple-cloud-dataproc-instances-for-each-priority-workload-and-then-turning-them-down-when-not-in-use)
  - [* May be imported from a bucket into a Hadoop cluster for analysis](#-may-be-imported-from-a-bucket-into-a-hadoop-cluster-for-analysis)
  - [* Transactional updates on relatively small datasets](#-transactional-updates-on-relatively-small-datasets)
## Notes

- Learn Bash

- cloud architecture specializations

## How to create a VM and dataset

Was learned before.

## Keywords

On a business case in cloud, pay attention to these:
* Challenges
* Cloud solution
* Impact


## First Module Review

* What are the common big data challenges that you will be building solutions for in this course?
  * Migrating existing on-premise workloads to the cloud
  * Analyzing large datasets at scale
  * Building streaming data pipelines
  * Applying machine learning to your datasets
* You have a large enterprise that will likely have many teams using their own Google Cloud Platform projects and resources. What should you be sure to have to help manage and administer these resources?
  * A defined Organization
  * Folders for teams and/or products
  * A defined access control policy with Cloud IAM
* Which of the following is NOT one of the advantages of Google Cloud security 
  * Google Cloud will automatically manage and curate your content and access policies to be safe for the public
* If you don't have a large dataset of your own but still want to practice writing queries and building pipelines on Google Cloud Platform, what should you do?
  * Practice with the datasets in the Google Cloud Public Datasets program
  * Find other public datasets online and upload them into BigQuery
  * Work to create your own dataset and then upload it into BigQuery for analysis 
* As you saw in the demo, Compute Engine nodes on GCP are:
  * Allocated on demand, and you pay for the time that they are up.


## Module Review
---------
Question 1

Complete the following:
You should feed your machine learning model your _______ and not your _______. It will learn those for itself!
- data,  rules
---------
Question 2

True or False: Cloud SQL is a big data analytics warehouse
* False
---------
Question 3

True or False: If you are migrating your Hadoop workload to the cloud, you must first rewrite all your Spark jobs to be compliant with the cloud. 
* False
---------
Question 4

You are thinking about migrating your Hadoop workloads to the cloud and you have a few workloads that are fault-tolerant (they can handle interruptions of individual VMs gracefully). What are some architecture considerations you should explore in the cloud? Choose all that apply
* Use PVMs or Preemptible Virtual Machines 
* Migrate your storage from on-cluster HDFS to off-cluster Google Cloud Storage (GCS)
* Consider having multiple Cloud Dataproc instances for each priority workload and then turning them down when not in use 
---------
Question 5

Google Cloud Storage is a good option for storing data that:
* May be required to be read at some later time (i.e. load a CSV file into BigQuery)
* May be imported from a bucket into a Hadoop cluster for analysis
---------
Question 6

Relational databases are a good choice when you need:
* Transactional updates on relatively small datasets
---------
Question 7

Cloud SQL and Cloud Dataproc offer familiar tools (MySQL and Hadoop/Pig/Hive/Spark). What is the value-add provided by Google Cloud Platform?
* Running it on Google infrastructure offers reliability and cost savings
* Fully-managed versions of the software offer no-ops
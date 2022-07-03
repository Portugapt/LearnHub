# Getting Started

Initial talk was about MongoDB vs Relational databases.

Existing databases are:  
* MongoDB
* Cassandra
* CouchDB
* Redis
* Memcache
* DynamoDB

## Git Repo

https://github.com/LinkedInLearning/Learning-MongoDB-2835008

## Install MongoDB in Ubuntu

Use official docker image
```bash
docker run -it --name mongeContainer -p 27017:27017 -v mongo_volume:/data/db -d mongo:latest
```

Install tools:  

```bash
sudo apt install mongodb-clients
sudo apt install mongo-tools
```


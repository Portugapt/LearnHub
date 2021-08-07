# Streaming Data Processing: Streaming Analytics and Dashboards

* Open VM instance
* Clone repo
* Set environment variables

## Creating a data source in Data Studio

Go to [DataStudio](https://datastudio.google.com/)

Create a Blank report

![alt text](./imgs//w2/img2.png "Image")
![alt text](./imgs//w2/img3.png "Image")
![alt text](./imgs//w2/img4.png "Image")

## Creating a bar chart using a calculated field

![alt text](./imgs//w2/img5.png "Image")

... 

## Creating a chart using a custom query

![alt text](./imgs//w2/img7.png "Image")

BigQuery -> Custom Query

E.g.: 
```sql
SELECT max(speed) as maxspeed, min(speed) as minspeed,
avg(speed) as avgspeed, highway
FROM `<PROJECTID>.demos.current_conditions`
group by highway
```


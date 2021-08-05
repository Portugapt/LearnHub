# Lab: Running Apache Spark jobs on Cloud Dataproc 

student-02-99d6402d5183@qwiklabs.net

qwiklabs-gcp-00-e03d5cfc90eb



Get the dataproc cluster created name
```bash
export DP_STORAGE="gs://$(gcloud dataproc clusters describe sparktodp --region=us-central1 --format=json | jq -r '.config.configBucket')"
```

Next up is a bunch of Spark code.
In the notebook 'PySpark-analysis-file'

---

To the command line
```bash
gsutil cp gs://$PROJECT_ID/sparktodp/spark_analysis.py spark_analysis.py
```


```bash
nano submit_onejob.sh
```
Copy paste
```bash
#!/bin/bash
gcloud dataproc jobs submit pyspark \
       --cluster sparktodp \
       --region us-central1 \
       spark_analysis.py \
       -- --bucket=$1
```
Press CTRL+X then Y and Enter key to exit and save. Cool trick m8


[Meaning of \$1](https://bash.cyberciti.biz/guide/$1)

```bash
chmod +x submit_onejob.sh
./submit_onejob.sh $PROJECT_ID
```


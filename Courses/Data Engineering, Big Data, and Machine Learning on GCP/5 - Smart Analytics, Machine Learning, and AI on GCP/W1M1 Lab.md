# Using the Natural Language API to classify unstructured text

What you'll learn

* Creating a Natural Language API request and calling the API with curl

* Using the NL API's text classification feature

* Using text classification to understand a dataset of news articles


qwiklabs-gcp-04-ac58cd2b31b9

-----
Setup

```bash
gcloud auth list

gcloud config list project
```

Enable **Google Cloud Natural Language API**. 

Create an API Key:  
Apis and Services -> Credentials -> Create Credentials -> API Key

AIzaSyB1xYNMlKeRGXQg0Vm1BUy4IAqW3YJPD9U 

```sql
export API_KEY=<YOUR_API_KEY>
```

----
Classify News Article


Create the file request.json:
```json
{
  "document":{
    "type":"PLAIN_TEXT",
    "content":"A Smoky Lobster Salad With a Tapa Twist. This spin on the Spanish pulpo a la gallega skips the octopus, but keeps the sea salt, olive oil, pimentón and boiled potatoes."
  }
}
```

Then in prompt:
```bash
curl "https://language.googleapis.com/v1/documents:classifyText?key=${API_KEY}" \
  -s -X POST -H "Content-Type: application/json" --data-binary @request.json
```

---- 
### Classifying a large text dataset

2004-2005 BBC news articles
```bash
gsutil cat gs://cloud-training-demos-text/bbc_dataset/entertainment/001.txt
```

### Creating a BigQuery table for our categorized text data

Create new BQ Dataset `news_classification_dataset`

New table `article_data`

Schema:
* article_text with type STRING
* category with type STRING
* confidence with type FLOAT

### Classifying news data and storing the result in BigQuery

```bash
export PROJECT=<your_project_name>
```

Create a service account:
```bash
gcloud iam service-accounts create my-account --display-name my-account
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:my-account@$PROJECT.iam.gserviceaccount.com --role=roles/bigquery.admin
gcloud iam service-accounts keys create key.json --iam-account=my-account@$PROJECT.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```
Take a deeper look at this code [!]


Create a `classify-text.py` file with the following code:
```python
from google.cloud import storage, language_v1, bigquery

# Set up our GCS, NL, and BigQuery clients
storage_client = storage.Client()
nl_client = language_v1.LanguageServiceClient()
# TODO: replace YOUR_PROJECT with your project id below
bq_client = bigquery.Client(project='my_project')

dataset_ref = bq_client.dataset('news_classification_dataset')
dataset = bigquery.Dataset(dataset_ref)
table_ref = dataset.table('article_data') # Update this if you used a different table name
table = bq_client.get_table(table_ref)

# Send article text to the NL API's classifyText method
def classify_text(article):
        response = nl_client.classify_text(
                document=language_v1.types.Document(
                        content=article,
                        type_='PLAIN_TEXT'
                )
        )
        return response

rows_for_bq = []
files = storage_client.bucket('cloud-training-demos-text').list_blobs()
print("Got article files from GCS, sending them to the NL API (this will take ~2 minutes)...")

# Send files to the NL API and save the result to send to BigQuery
for file in files:
        if file.name.endswith('txt'):
                article_text = file.download_as_bytes()
                nl_response = classify_text(article_text)
                if len(nl_response.categories) > 0:
                        rows_for_bq.append((str(article_text), str(nl_response.categories[0].name), nl_response.categories[0].confidence))

print("Writing NL API article data to BigQuery...")
# Write article text + category data to BQ
errors = bq_client.insert_rows(table, rows_for_bq)
assert errors == []
```

Analyze table in BQ


Analyzing categorized news data in BigQuery

```sql
SELECT * FROM `news_classification_dataset.article_data`
WHERE category = "/Arts & Entertainment/Music & Audio/Classical Music"
```

```sql
SELECT * FROM `news_classification_dataset.article_data`
WHERE category = "/Arts & Entertainment/Music & Audio/Classical Music"
```

E.g. 90% confidence +

```sql
SELECT
  article_text,
  category
FROM `news_classification_dataset.article_data`
WHERE cast(confidence as float64) > 0.9
```


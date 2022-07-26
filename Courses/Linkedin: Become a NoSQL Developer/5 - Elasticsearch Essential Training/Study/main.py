from datetime import datetime
from operator import truediv
from elasticsearch import Elasticsearch
es = Elasticsearch(['http://localhost:9200'])

## test 1
doc = {
    'author': 'kimchy',
    'text': 'Elasticsearch: cool. bonsai cool.',
    'timestamp': datetime.now(),
}
resp = es.index(index="test-index", id=1, document=doc)
print(resp['result'])


###

# GET /_cat/indices?v=true

# PUT sales
# {
#     "mappings": {
#         "properties": {
#             "type": { "type" : "keyword"},
#             "orderID": { "type" : "text"},
#             "orderAmount": { "type" : "text"},
#         }
#     }
# }

# POST /sales/_doc/order-1
# {
#     "type": "order",
#     "orderID": "123",
#     "orderAmount": "500"
# }

mapping = ''' {
    "mappings": {
        "properties": {
            "type": { "type" : "keyword"},
            "orderID": { "type" : "text"},
            "orderAmount": { "type" : "text"},
        }
    }
} '''

es.indices.create(index='sales', ignore=400, body=mapping)

Question 1

Dataflow offers the following that makes it easy to create resilient streaming pipelines when working with unbounded data:

- [X] Ability to flexibly reason about time
- [X] Controls to ensure correctness
- [ ] Global message bus to buffer messages
- [ ] SQL support to query in-process results


Question 2

| Product        	| Role                                                                              	|
|----------------	|-----------------------------------------------------------------------------------	|
| __ 1. Pub/Sub  	| A. Controls to handle late-arriving and out-of-order data                         	|
| __ 2. Dataflow 	| B. Global message queue                                                           	|
| __ 3. BigQuery 	| C. Latency in the order of milliseconds when querying against overwhelming volume 	|
| __ 4. Bigtable 	| D. Query data as it arrives from streaming pipelines                              	|

1. B
2.  A
3.  D
4.  C


---------
Serverless Messaging with Cloud Pub/Sub
---

Q1.
Which of the following about Cloud Pub/Sub is **NOT** true?
- [ ] Pub/Sub simplifies systems by removing the need for every component to speak to every component
- [X] Pub/Sub connects applications and services through a messaging infrastructure
- [ ] Pub/Sub stores your messages indefinitely until you request it

Q2.
True or False?   
Cloud Pub/Sub guarantees that messages delivered are in the order they were received
* False

Q3.
Which of the following about Cloud Pub/Sub topics and subscriptions are true?
- [x] 1 or more publisher(s) can write to the same topic
- [X] 1 or more subscriber(s) can request from the same subscription
- [ ] Each topic will deliver ALL messages for a topic for each subscriber
- [ ] Each topic MUST have at least 1 subscription

Q4.
Which of the following delivery methods is ideal for subscribers needing close to real time performance?

- [ ] Pull Delivery
- [X] Push Delivery

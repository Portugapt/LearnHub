
# Questions
------------
------------
What is QPS

# Pratical Problems
------------
------------
![Example](https://i.imgur.com/S8e8Itf.png)

After training, it can work well in.
There are however complicated problems ahead.

Concept drift or data drift is one of the **practical problems**.


POC to Production Gap. Is a concept that says that 5-10% of the project code is ML Code.

![Example](https://i.imgur.com/yfKn4iu.png)


# Steps of an ML Project
------------
------------
## Scoping

What is X and Y

## Data

Define data and establish baseline

Label and organize it.

## Modeling

Select and train models

Perform **error analysis**

## Deployment

Only after live traffic you understand what is necessary for the system to work well.

Monitor \& maintain the system.

Eg feeding back the live data to update the model.

![Lifecycle](https://i.imgur.com/MAVCQSI.png)

# Case study - Speech recognition
------------
------------
## Scoping

* Decide on key metrics (Estimate or Guesstimate)
  * Accuracy latency, throughput
* Estimate resources and timeline

## Data

* Is the data labeled consistenly?
  *  In the future we'll see how to detect and work on inconsistencies.
* How much silence before/after each clip?
* How to perform volume normalization?

## Modeling

1. Code (algorithm/model)
2. Hyperparameters
3. Data

these output the ML Model

***In product teams, focus on the hyperparameters and data.***         
In academia, focus on Code and hyperparameters.

Error analysis tells where the model still falls short.

## Deployment

![Full lifecycle](https://i.imgur.com/Z6aECyT.png)

# Deployment Module
------------
------------
## Challenges

* Statistical
    * Concept drift (Change in X to Y) and Data drift (Change to X)
    * Sometimes the data changes rapidly, other times it's more gradual.
* Software

## Statistical challenges
Exemple:   
Predict the cost of a house (Y) based on the size (X)
* Concept Drift
  * The market shifts, and houses of size X start costing more. (What is Y given X changes)
* Data drift
  * People start building larger and smaller houses. (The distribution of X changes)

## Software Challenges

* Realtime or batch?
* Cloud vs Edge/Browser? (Edge is edge note aka final device of the model)
* Compute resources (CPU/GPU/memory)
* Latency, throughput (QPS)
* Logging (For analysis and review, have more data for training)
* Security and privacy

# Quiz 1
------------
------------
## 1. Which of these are stages of the machine learning project lifecycle? Check all that apply.

* [X] Deployment
* [ ] Configuration
* [X] Modeling
* [X] Scoping
* [X] Data

## 2. Which of these is not an advantage of a typical edge deployment compared to a typical cloud deployment?

* [ ] Lower latency
* [ ] Less network bandwidth needed
* [ ] Can function even if network connection is down
* [X] More computational power available

## 3. In the speech recognition example, what is the problem with some labelers transcribing audio as “Um, today’s weather” and others transcribing “Umm..., today’s weather”?

* [ ] We should not be transcribing “Umm.” The correct transcription, which serves the user's needs better, is just “Today’s weather.

* [x] Either transcription is okay, but the inconsistency is problematic.

* [ ] The second is grammatically incorrect and we should use the first transcription. 

* [ ] The first is grammatically incorrect and we should use the second transcription.

## 4. After a system is deployed, monitoring and maintaining the system will help us handle cases of concept drift or data drift.

* [ ] False

* [x] True

## 5. Which statement is a more accurate description of the full cycle of a machine learning project?

* [ ] It is a linear process, in which we move step-by-step from scoping to deployment. (That’s why we call it a cycle. Bicycles are only good at going forward, not backward.)

* [x] It is an iterative process, where during a later stage we might go back to an earlier stage. (That’s why we call it a cycle--it’s a circular process.)


# Deployment patterns

## Common deployment patterns

### Shadow mode deployment

![Example shadow mode](https://i.imgur.com/i2Vn49L.png)

### Canary deployment

![Example canary](https://i.imgur.com/kuRQz00.png)

### Blue/Green deployment

![Example bluegreen](https://i.imgur.com/T1KaJkk.png)

## Degrees of automation

![Degrees](https://i.imgur.com/iAqlB8y.png)

# Monitoring

## Tool: Monitoring dashboard

![Monitor Dashboard](https://i.imgur.com/Cx2dB0N.png)

## Set of metrics (Audio example)

![Metrics examples](https://i.imgur.com/LEz7DLy.png)

## ML Deployment is iterative

Some metrics don't matter, and some other metrics might have been missed in the first deployment.

Also some metrics can have thresholds for alarms. 

It's ok to adapt the metrics over time.

## Update a model

* Manual retraining
* Automatic retraing

# Pipeline monitoring

Metrics that monitor each of the components and the pipeline as a whole.

Monitor Software, input and output metrics.

## Questions

* How quickly do the metrics change? (Data in this example)
  * User data generally has a slow drift
  * Biz2Biz data can shift fast.

Just generic examples.

# Graded assignment


## 1. You’ve built a new system for making loan approval decisions. For now, its output is not used in any decision making process, and a human loan officer is solely responsible for deciding what loans to approve. But the system’s output is logged for analysis. What is this type of deployment called?

* [X] Shadow mode deployment

* [ ] Canary deployment

* [ ] Red green deployment

* [ ] Blue green deployment


## 2. On a new social media platform, you’re rolling out a new anti-spam system to flag and hide spammy posts. Your team decides to roll out the anti-spam filter via a canary deployment, and roll it out to 1% of users initially. Which of these would you advocate?

* [ ] Monitor that 1% of users’ reaction, and if it goes well, flip the switch to send all traffic (100%) to the system. 

* [ ] After a successful canary deployment, begin to implement a shadow mode deployment. 

* [x] Monitor that 1% of users’ reaction, and either gradually ramp up (if it’s going well) or rollback (if not) 

* [ ] Use a plan to ramp up to more users at a fixed rate: 1% in the first week, 2% in second week, 4% in third, and so on, so that the rollout can be well planned and managed.


## 3. You’re building a healthcare screening system, where you input a patient’s symptoms, and for the easy cases (such as an obvious case of the common cold) the system will give a recommendation directly, and for the harder cases it will pass the case on to a team of in-house doctors who will form their own diagnosis independently. What degree of automation are you implementing in this example for patient care? 

* [ ] Human only  

* [x] Partial Automation

* [ ] Full Automation

* [ ] Shadow mode 

## 4. You have built and deployed an anti-spam system that inputs an email and outputs either 0 or 1 based on whether the email is spam. Which of these will result in either concept drift or data drift?

* [x] Spammers trying to change the wording used in emails to get around your spam filter.

* [ ] Cloud computational costs going down, resulting in a lower cost to process each email received.

* [ ] Updating a monitoring dashboard to keep track of new metrics.

* [ ] None of these will result in either concept drift or data drift.

## 5. Which of these statements is a more accurate description of deployment?

* [ ] Because deployment is a high stakes event, it's critical to design the right system, so that immediately after launch it will immediately work reliably and scale effectively.

* [X] It is an iterative process, where you should expect to make multiple adjustments (such as metrics monitored using dashboards or percentage of traffic served) to work towards optimizing the system.

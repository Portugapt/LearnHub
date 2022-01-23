# Model Monitoring and Logging

- [Model Monitoring and Logging](#model-monitoring-and-logging)
  - [Model Monitoring](#model-monitoring)
  - [Observability in ML](#observability-in-ml)
  - [Monitoring Targets in ML](#monitoring-targets-in-ml)
  - [Logging for ML Monitoring](#logging-for-ml-monitoring)
  - [What is Model Decay?](#what-is-model-decay)
  - [Resources](#resources)
  - [Lab 1](#lab-1)
  - [Quiz 1 - Model Monitoring and Logging](#quiz-1---model-monitoring-and-logging)
    - [What issue arises when models are automatically trained on data collected during production?](#what-issue-arises-when-models-are-automatically-trained-on-data-collected-during-production)
    - [Is observability more attainable in modern systems?](#is-observability-more-attainable-in-modern-systems)
    - [In the realm of ML engineering, the operational concerns include monitoring system performance. What measures do we use for doing so? (Select all that apply)](#in-the-realm-of-ml-engineering-the-operational-concerns-include-monitoring-system-performance-what-measures-do-we-use-for-doing-so-select-all-that-apply)
    - [What are the advantages of Logging for ML Monitoring? (Select all that apply)](#what-are-the-advantages-of-logging-for-ml-monitoring-select-all-that-apply)
  - [Quiz 2 - Model Decay](#quiz-2---model-decay)
    - [Suppose that you have a very accurate model for a social app that uses several features to predict whether a user is a spammer or not. You trained the model with a particular idea of what a spammer was, for example, a user who sends ten messages in one minute. Over time, the app grew and became more popular, but the outcome of the predictions has drastically changed. As people are chatting and messaging more, now sending ten messages in a minute becomes normal and not something that only spammers do. What kind of drift causes this spam-detection model's predictive ability to decay?](#suppose-that-you-have-a-very-accurate-model-for-a-social-app-that-uses-several-features-to-predict-whether-a-user-is-a-spammer-or-not-you-trained-the-model-with-a-particular-idea-of-what-a-spammer-was-for-example-a-user-who-sends-ten-messages-in-one-minute-over-time-the-app-grew-and-became-more-popular-but-the-outcome-of-the-predictions-has-drastically-changed-as-people-are-chatting-and-messaging-more-now-sending-ten-messages-in-a-minute-becomes-normal-and-not-something-that-only-spammers-do-what-kind-of-drift-causes-this-spam-detection-models-predictive-ability-to-decay)
    - [When mitigating data drift, if you don't have enough recently labeled data to create an entirely new dataset, how can you determine what data from your previous training dataset is still valid? (Select all that apply)](#when-mitigating-data-drift-if-you-dont-have-enough-recently-labeled-data-to-create-an-entirely-new-dataset-how-can-you-determine-what-data-from-your-previous-training-dataset-is-still-valid-select-all-that-apply)
    - [True or False: Having restructured a new training dataset after detecting model decay, you must start over by resetting and completely retraining your model. There is no way around it.](#true-or-false-having-restructured-a-new-training-dataset-after-detecting-model-decay-you-must-start-over-by-resetting-and-completely-retraining-your-model-there-is-no-way-around-it)
    - [If you can't automate the process of finding out when model retraining is required, what are some good ideas for policies to establish when to do it? (Select all that apply)](#if-you-cant-automate-the-process-of-finding-out-when-model-retraining-is-required-what-are-some-good-ideas-for-policies-to-establish-when-to-do-it-select-all-that-apply)

## Model Monitoring

![mm1](https://i.imgur.com/EosDgEL.png)

But, you will also need to include monitoring of the systems and infrastructure which are included in your entire product or service such as databases and web servers. That kind of monitoring is only concerned with the basic operation of your product or service and not the model itself, but is critical to your users experience. Basically, if the system is down, it really doesn't matter how good your model is.

![mm2](https://i.imgur.com/8Vs8H2L.png)

![mm3](https://i.imgur.com/eOT0LLB.png)

![mm4](https://i.imgur.com/hVEykoP.png)

ML Monitoring has two more aspects in addiction to software monitoring, the data and the model.
Code and config also take on additional complexity and sensitivity in an ML system due to two aspects, entanglement and configuration. Entanglement, and no, I'm not referring here to quantum entanglement, refers to the issue where changing anything, changes everything. Here, you need to be careful with feature engineering and features selection and understand your model sensitivity. Configuration can also be an issue because model hyper parameters, versions and features are often controlled in a system config and the slightest error here can cause radically different model behavior that won't be picked up with traditional software tests. Again, requiring additional very specialist monitoring.

## Observability in ML

![obb1](https://i.imgur.com/pymCJ3O.png)

![ob2](https://i.imgur.com/kJlhOt3.png)

![ob3](https://i.imgur.com/bcr2JQZ.png)

![ob4](https://i.imgur.com/tIVdTSL.png)

## Monitoring Targets in ML

![MT1](https://i.imgur.com/HoODAea.png)

![MT2](https://i.imgur.com/y8P1RPy.png)

![MT3](https://i.imgur.com/QlmwToY.png)

## Logging for ML Monitoring

![logging1](https://i.imgur.com/wBCcUmg.png)

![log2](https://i.imgur.com/lTEM9RS.png)

![log3](https://i.imgur.com/JOlcGkq.png)

![log4](https://i.imgur.com/xXNZKTq.png)

![log5](https://i.imgur.com/hXnYImg.png)

![log6](https://i.imgur.com/nXvPdKU.png)

Logging can serve as a foundation for new training data.

![log7](https://i.imgur.com/NDfrps1.png)

![log8](https://i.imgur.com/5Jwpqyy.png)

![log9](https://i.imgur.com/eKZZut3.png)

## What is Model Decay?




## Resources

https://christophergs.com/machine%20learning/2020/03/14/how-to-monitor-machine-learning-models/

https://neptune.ai/blog/retraining-model-during-deployment-continuous-training-continuous-testing   

## Lab 1

https://googlecoursera.qwiklabs.com/focuses/19806089?parent=lti_session

## Quiz 1 - Model Monitoring and Logging

Question 1

### What issue arises when models are automatically trained on data collected during production?
1 / 1 point

* Negative Feedback Loops
Correct

!!! note Nailed it! Data collected in production could be biased or corrupted in some way. If a model is automatically trained on such data, it will perform poorly as a result.

### Is observability more attainable in modern systems?
1 / 1 point

* No, observability gets more challenging when you consider modern systems.
Correct

!!! note Absolutely! Observability becomes a more complex problem when you consider modern systems, which means that you often need to rely on vendor monitoring systems to collect and sometimes aggregate data.

### In the realm of ML engineering, the operational concerns include monitoring system performance. What measures do we use for doing so? (Select all that apply)
1 / 1 point

* IO/memory/disk utilization
Correct

!!! note Right! You need to keep a close eye on the system performance, including the usage of CPU, memory, disk, and network I/O. Analyzing these metrics is very significant for ensuring that the machine learning service is fully operational.

* Latency
Correct

!!! note Good job! Monitoring latency to serve prediction is essential because the expected action should happen immediately for real-time use cases.

* Uptime
Correct

!!! note Correct! Uptime is a measure of computer operating system reliability or stability. It is expressed as the percentage of time a computer can be left unattended without crashing or needing to be rebooted for administrative or maintenance purposes.

### What are the advantages of Logging for ML Monitoring? (Select all that apply)
1 / 1 point

* Logs provide valuable insight.
Correct

!!! note Right on track! Event logs provide valuable insight along with context, adding detail that averages and percentiles don’t surface. However, you must be careful to provide the right amount of context without obscuring the really valuable information in too much extraneous detail.

* Logs focus on specific events.
Correct

!!! note You’ve figured it out! While metrics show the trends of a service or an application, logs focus on specific events, including both log messages printed from your application as well as warnings, errors, or debug messages which are generated automatically.

* Logs are easy to generate.
Correct

!!! note Excellent! Logs are very easy to generate, since they are just strings, blobs of JSON, or typed key-value pairs.


## Quiz 2 - Model Decay

### Suppose that you have a very accurate model for a social app that uses several features to predict whether a user is a spammer or not. You trained the model with a particular idea of what a spammer was, for example, a user who sends ten messages in one minute. Over time, the app grew and became more popular, but the outcome of the predictions has drastically changed. As people are chatting and messaging more, now sending ten messages in a minute becomes normal and not something that only spammers do. What kind of drift causes this spam-detection model's predictive ability to decay?
1 / 1 point

* Concept Drift
Correct

!!! note Nailed it! The model's original idea about what it means to be a spammer has changed, and now sending ten messages in a minute becomes normal. In other words, the concept of spammers has drifted. Consequently, since you haven't updated your model, it will predict these non-spammers as spammers (a false positive).

### When mitigating data drift, if you don't have enough recently labeled data to create an entirely new dataset, how can you determine what data from your previous training dataset is still valid? (Select all that apply)
1 / 1 point

* Using a statistical measure like the Kullback–Leibler divergence.
Correct

!!! note Nice job! Kullback–Leibler divergence, also called relative entropy, measures how much the probability distribution has drifted from the original position.

* Using an unsupervised learning technique like clustering.
Correct

!!! note That's right! Clustering identifies relevant portions of the original dataset to retrain a model's functionality that has become dispersed. It is a form of restructuring, and hence it could be a way of direct preventative maintenance.

### True or False: Having restructured a new training dataset after detecting model decay, you must start over by resetting and completely retraining your model. There is no way around it.
1 / 1 point

* False
Correct

!!! note Exactly! You have two choices for how to train your model. Using your new data, you can either start over or continue training your model and fine-tuning it from the last checkpoint.

### If you can't automate the process of finding out when model retraining is required, what are some good ideas for policies to establish when to do it? (Select all that apply)
1 / 1 point

* Retrain on new data availability.
Correct

!!! note You've got it! When the availability of new training data limits you, you may be forced to retain as much of your old training data for as long as possible and avoid fully retraining your model.

* Retrain on schedule.
Correct

!!! note Keep it up! You could also just retrain your model according to a schedule. In practice, this is what many people do because it's simple to understand and works reasonably well in many domains. You should be careful, though, not to retrain the model too often or not often enough.

* Retrain on demand.
Correct

!!! note Way to go! You can retrain your model whenever it seems necessary, including situations like noticing drift or needing to change (add or remove) class labels or features, for example.
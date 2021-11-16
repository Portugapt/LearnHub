- [Questions](#questions)
- [Why is data definition hard?](#why-is-data-definition-hard)
- [Human level performance (HLP)](#human-level-performance-hlp)
- [Obtaining Data & Pipelines](#obtaining-data--pipelines)
  - [Pipelines](#pipelines)
- [Balanced train/dev/test splits](#balanced-traindevtest-splits)
- [Quiz - Data Stage of the ML Production Lifecycle](#quiz---data-stage-of-the-ml-production-lifecycle)
  - [1. Which of these statements do you agree with regarding structured vs. unstructured data problems?](#1-which-of-these-statements-do-you-agree-with-regarding-structured-vs-unstructured-data-problems)
  - [2. Take speech recognition. Some labelers transcribe with “...” (as in, “Um… today’s weather”) whereas others do so with commas “,”. Human-level performance (HLP) is measured according to how well one transcriber agrees with another. You work with the team and get everyone to consistently use commas “,”. What effect will this have on HLP?](#2-take-speech-recognition-some-labelers-transcribe-with--as-in-um-todays-weather-whereas-others-do-so-with-commas--human-level-performance-hlp-is-measured-according-to-how-well-one-transcriber-agrees-with-another-you-work-with-the-team-and-get-everyone-to-consistently-use-commas--what-effect-will-this-have-on-hlp)
  - [3. Take a phone visual inspection problem. Suppose even a human inspector looking at an image cannot tell if there is a scratch. If however the same inspector were to look at the phone directly (rather than an image of the phone) then they can clearly tell if there is a scratch. Your goal is to build a system that gives accurate inspection decisions for the factory (not publish a paper). What would you do?](#3-take-a-phone-visual-inspection-problem-suppose-even-a-human-inspector-looking-at-an-image-cannot-tell-if-there-is-a-scratch-if-however-the-same-inspector-were-to-look-at-the-phone-directly-rather-than-an-image-of-the-phone-then-they-can-clearly-tell-if-there-is-a-scratch-your-goal-is-to-build-a-system-that-gives-accurate-inspection-decisions-for-the-factory-not-publish-a-paper-what-would-you-do)
  - [4. You are building a system to detect cats. You ask labelers to please “use bounding boxes to indicate the position of cats.” Different labelers label as follows:](#4-you-are-building-a-system-to-detect-cats-you-ask-labelers-to-please-use-bounding-boxes-to-indicate-the-position-of-cats-different-labelers-label-as-follows)
  - [5. You are building a visual inspection system. HLP is measured according to how well one inspector agrees with another. Error analysis finds:](#5-you-are-building-a-visual-inspection-system-hlp-is-measured-according-to-how-well-one-inspector-agrees-with-another-error-analysis-finds)
  - [6. To implement the data iteration loop effectively, the key is to take all the time that’s needed to construct the right dataset first, so that all development can be done on that dataset without needing to spend time to update the data.](#6-to-implement-the-data-iteration-loop-effectively-the-key-is-to-take-all-the-time-thats-needed-to-construct-the-right-dataset-first-so-that-all-development-can-be-done-on-that-dataset-without-needing-to-spend-time-to-update-the-data)
  - [7. You have a data pipeline for product recommendations that (i) cleans data by removing duplicate entries and spam, (ii) makes predictions. An engineering team improves the system used for step (i). If the trained model for step (ii) remains the same, what can we confidently conclude about the performance of the overall system?](#7-you-have-a-data-pipeline-for-product-recommendations-that-i-cleans-data-by-removing-duplicate-entries-and-spam-ii-makes-predictions-an-engineering-team-improves-the-system-used-for-step-i-if-the-trained-model-for-step-ii-remains-the-same-what-can-we-confidently-conclude-about-the-performance-of-the-overall-system)
  - [8. What is the primary goal of building a PoC (proof of concept) system?](#8-what-is-the-primary-goal-of-building-a-poc-proof-of-concept-system)
  - [9. MLOps tools can store meta-data to keep track of data provenance and lineage. What do the terms data provenance and lineage mean?](#9-mlops-tools-can-store-meta-data-to-keep-track-of-data-provenance-and-lineage-what-do-the-terms-data-provenance-and-lineage-mean)
  - [10. You are working on phone visual inspection, where the task is to use an input image, x, to classify defects, y. You have stored meta-data for your entire ML system, such as which factory each image came from. Which of the following are reasonable uses of meta-data?](#10-you-are-working-on-phone-visual-inspection-where-the-task-is-to-use-an-input-image-x-to-classify-defects-y-you-have-stored-meta-data-for-your-entire-ml-system-such-as-which-factory-each-image-came-from-which-of-the-following-are-reasonable-uses-of-meta-data)

# Questions

# Why is data definition hard?

Three different ways to label the same Iguana example. 
None of them is more wrong than the other, but this creates problems in definition.

![](https://i.imgur.com/Vfg05Gl.png)

Inconsistent labeling is a problem for the Algorithm.
![](https://i.imgur.com/FnZIOce.png)


This week we'll learn how to define what is X and what is Y
![](https://i.imgur.com/fDFKiyN.png)

![](https://i.imgur.com/2zLC2l1.png)

![](https://i.imgur.com/DtrTpP0.png)

![](https://i.imgur.com/jOYTqiS.png)


Always try to choose a person that worked on the quadrant of the problem you are trying to solve. They are quicker to adapt and can help much more.
![](https://i.imgur.com/S9drfiS.png)


On label inconsistency

![](https://i.imgur.com/Fz4OvJs.png)

![](https://i.imgur.com/c6U9hlF.png)

![](https://i.imgur.com/M49sXmK.png)


# Human level performance (HLP)

![](https://i.imgur.com/afVbbhj.png)


![](https://i.imgur.com/UeEHC8Y.png)

![](https://i.imgur.com/s3Pme2m.png)

# Obtaining Data & Pipelines

![](https://i.imgur.com/Csck1sH.png)

Collect as much as possible in a set of time. Use error analysis to come up with more data, or tha access if the problem is solvable.

>then is much better to
quickly collect a small amount of data,
train a model and then use error analysis to tell you
if is worth your while to go out to collect more data.
In terms of getting the data you need,
one other step I often carry out is to
take inventory of possible data sources.


![](https://i.imgur.com/xJ5axLi.png)


## Pipelines

![](https://i.imgur.com/zXxxJso.png)

![](https://i.imgur.com/njja1RN.png)

![](https://i.imgur.com/3cO2Vhf.png)

Keeping track of data provinence can really help in the future to fix problems or maintain the model lifecycle

>The takeaway from this video is that for
large complex machine learning
systems that you might need to maintain,
keeping track of data provenance and
lineage can make your life much easier.
As part of building out the systems,
consider keeping track of metadata,
which can help you with tracking data provenance,
but also error analysis. 

# Balanced train/dev/test splits

![](https://i.imgur.com/hgYx2yf.png)

# Quiz - Data Stage of the ML Production Lifecycle

## 1. Which of these statements do you agree with regarding structured vs. unstructured data problems?

- [ ] It is generally easier for humans to label data on structured data, and easier to apply data augmentation on unstructured data.

- [X] It is generally easier for humans to label data and to apply data augmentation on unstructured data than structured data.

- [ ] It is generally easier for humans to label data and to apply data augmentation on structured data than unstructured data. 

- [ ] It is generally easier for humans to label data on unstructured data, and easier to apply data augmentation on structured data.

## 2. Take speech recognition. Some labelers transcribe with “...” (as in, “Um… today’s weather”) whereas others do so with commas “,”. Human-level performance (HLP) is measured according to how well one transcriber agrees with another. You work with the team and get everyone to consistently use commas “,”. What effect will this have on HLP?

- [ ] HLP will decrease.

- [X] HLP will increase.

- [ ] HLP will stay the same.


## 3. Take a phone visual inspection problem. Suppose even a human inspector looking at an image cannot tell if there is a scratch. If however the same inspector were to look at the phone directly (rather than an image of the phone) then they can clearly tell if there is a scratch. Your goal is to build a system that gives accurate inspection decisions for the factory (not publish a paper). What would you do?


- [ ] Get a big dataset of many training examples, since this is a challenging problem that will require a big dataset to do well on. 

- [ ] Carefully measure HLP on this problem (which will be low) to make sure the algorithm can match HLP.

- [X] Try to improve their imaging (camera/lighting) system to improve the quality or clarity of the input images, x.  

- [ ] Try to improve the consistency of the labels, y.


## 4. You are building a system to detect cats. You ask labelers to please “use bounding boxes to indicate the position of cats.” Different labelers label as follows:
![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/d49R28lAQ52PUdvJQEOdtA_f34b734b43d14c439cdc464d76e975f1_Quizz_Image.png?expiry=1636761600000&hmac=6r4pBKy2bGd6t6EEKMQYRPkRM52YrL2l_QCuijJnNNs)

**What is the most likely cause of this?**


- [X] Ambiguous labeling instructions.

- [ ] Lazy labelers. 

- [ ] Labelers have not had enough coffee. 

- [ ] That this should have been posed as a segmentation rather than a detection task. 

## 5. You are building a visual inspection system. HLP is measured according to how well one inspector agrees with another. Error analysis finds:

| Type of defect 	| Accuracy 	| HLP 	| % of data 	|
|:--------------:	|:--------:	|:---:	|:---------:	|
| Scratch        	| 95%      	| 98% 	| 50%       	|
| Discoloration  	| 90%      	| 90% 	| 50%       	|

**You decide that it might be worth checking for label consistency on both scratch and discoloration defects. If you had to pick one to start with, which would you pick?**

- [ ] It is more promising to check (and potentially improve) label consistency on scratch defects than discoloration defects, since HLP is higher on scratch defects and thus it’s more reasonable to expect high consistency.

- [X] It is more promising to check (and potentially improve) label consistency on discoloration defects than scratch defects. Since HLP is lower on discoloration, it's possible that there might be ambiguous labelling instructions that is affecting HLP.


## 6. To implement the data iteration loop effectively, the key is to take all the time that’s needed to construct the right dataset first, so that all development can be done on that dataset without needing to spend time to update the data.

- [X] False

- [ ] True


## 7. You have a data pipeline for product recommendations that (i) cleans data by removing duplicate entries and spam, (ii) makes predictions. An engineering team improves the system used for step (i). If the trained model for step (ii) remains the same, what can we confidently conclude about the performance of the overall system?

- [ ] It will get worse because changing an earlier stage in a data pipeline always results in worse performance of the later stages.

- [ ] It will definitely improve since the data is now more clean.

- [ ] It will get worse because stage (ii) is now experiencing data/concept drift.

- [X] It's not possible to say - it may perform better or worse.

## 8. What is the primary goal of building a PoC (proof of concept) system?


- [ ] To build a robust deployment system.

- [ ] To select the most appropriate ML architecture for a task.

- [X] To check feasibility and help decide if an application is workable and worth deploying.

- [ ] To collect sufficient data to build a robusts system for deployment.

## 9. MLOps tools can store meta-data to keep track of data provenance and lineage. What do the terms data provenance and lineage mean?

- [ ] Data provenance refers to the sequence of processing steps applied to a dataset, and data lineage refers to where the data comes from.

- [ ] Data provenance refers data pipeline, and data lineage refers to the age of the data (i.e., how recently was it collected).

- [X] Data provenance refers to where the data comes from, and data lineage the sequence of processing steps applied to it.

- [ ] Data provenance refers the input x, and data lineage refers to the output y.

## 10. You are working on phone visual inspection, where the task is to use an input image, x, to classify defects, y. You have stored meta-data for your entire ML system, such as which factory each image came from. Which of the following are reasonable uses of meta-data?

- [ ] As an alternative to having to comment your code.

- [ ] As another input provided to human labelers (in addition to the image x) to boost HLP.

- [X] Keeping track of data provenance and lineage.

- [X] To suggest tags or to generate insights during error analysis.
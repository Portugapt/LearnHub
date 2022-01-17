# MLOps Lifecycle

- [MLOps Lifecycle](#mlops-lifecycle)
  - [Importance of data](#importance-of-data)
  - [Academia VS Production](#academia-vs-production)
  - [DAGs](#dags)
  - [TF Extended](#tf-extended)
  - [Key Considerations](#key-considerations)
  - [Questions to take in consideration](#questions-to-take-in-consideration)
  - [Slow and Fast drifts](#slow-and-fast-drifts)
  - [Process feedback](#process-feedback)
  - [ML lines](#ml-lines)
  - [Detecting data issues](#detecting-data-issues)
    - [Types of skews](#types-of-skews)
  - [Summary](#summary)
  - [Quiz 1 - Intro to MLEP](#quiz-1---intro-to-mlep)
    - [Static datasets are used for production ML modeling.](#static-datasets-are-used-for-production-ml-modeling)
    - [In production ML, the design priority is fast training.](#in-production-ml-the-design-priority-is-fast-training)
    - [Developers adhere to modern software development to produce low-maintenance software, and to address project evolution. Select all the key aspects of modern software development (Check all that apply):](#developers-adhere-to-modern-software-development-to-produce-low-maintenance-software-and-to-address-project-evolution-select-all-the-key-aspects-of-modern-software-development-check-all-that-apply)
    - [Model-performance needs to be continuously monitored, and new data, ingested and re-trained.](#model-performance-needs-to-be-continuously-monitored-and-new-data-ingested-and-re-trained)
    - [ML pipeline workflows are almost always DAGs.](#ml-pipeline-workflows-are-almost-always-dags)
    - [TensorFlow Extended (TFX) is an end-to-end platform for deploying production ML pipelines.](#tensorflow-extended-tfx-is-an-end-to-end-platform-for-deploying-production-ml-pipelines)
    - [Production machine learning combines which two key disciplines?](#production-machine-learning-combines-which-two-key-disciplines)
    - [What are the unique challenges to overcome in a production-grade ML system? (Check all that apply)](#what-are-the-unique-challenges-to-overcome-in-a-production-grade-ml-system-check-all-that-apply)
    - [Production grade machine learning challenges are addressed by implementing an important concept:](#production-grade-machine-learning-challenges-are-addressed-by-implementing-an-important-concept)
    - [TensorFlow Lite is a deep learning framework to deploy TFX pipelines into:](#tensorflow-lite-is-a-deep-learning-framework-to-deploy-tfx-pipelines-into)
  - [Quiz 2 - Data Collection](#quiz-2---data-collection)
    - [In ML, data are first-class citizens?](#in-ml-data-are-first-class-citizens)
    - [A data pipeline is a series of data processing steps such as:](#a-data-pipeline-is-a-series-of-data-processing-steps-such-as)
    - [Is the Data pipeline vital for the success of the production ML system?](#is-the-data-pipeline-vital-for-the-success-of-the-production-ml-system)
    - [What do you apply to maximize predictive signals in your data?](#what-do-you-apply-to-maximize-predictive-signals-in-your-data)
    - [Your training data should reflect the diversity and cultural context of the people who will use it. What can be done to mitigate inherent biases in a given data set?](#your-training-data-should-reflect-the-diversity-and-cultural-context-of-the-people-who-will-use-it-what-can-be-done-to-mitigate-inherent-biases-in-a-given-data-set)
    - [More often than not,  ML systems can fail the users it serves. In this context, what is representational harm?](#more-often-than-not--ml-systems-can-fail-the-users-it-serves-in-this-context-what-is-representational-harm)
    - [Accurate labels are necessary to properly train supervised models. Many times, human subjects known as raters perform this labeling effort. What are the main categories of human raters? (check all that apply).](#accurate-labels-are-necessary-to-properly-train-supervised-models-many-times-human-subjects-known-as-raters-perform-this-labeling-effort-what-are-the-main-categories-of-human-raters-check-all-that-apply)
  - [Quiz 3 - Data Labeling](#quiz-3---data-labeling)
    - [Which factors substantially complicate production machine learning? (Check all that apply)](#which-factors-substantially-complicate-production-machine-learning-check-all-that-apply)
    - [Direct Labeling is one of the methods used in production ML to label data. About it we can say that:](#direct-labeling-is-one-of-the-methods-used-in-production-ml-to-label-data-about-it-we-can-say-that)
    - [A cardiologist labeling MRI images is a typical example of Direct Labeling.](#a-cardiologist-labeling-mri-images-is-a-typical-example-of-direct-labeling)
    - [Quiz 4 - Issues in Training Data](#quiz-4---issues-in-training-data)
    - [What formula represents a dataset shift?](#what-formula-represents-a-dataset-shift)
    - [What measure is typically used to determine the degree of data drift?](#what-measure-is-typically-used-to-determine-the-degree-of-data-drift)
    - [Distribution skew occurs when the distribution of the training dataset is significantly different from the distribution of the serving dataset, and is typically caused by: (check all that apply).](#distribution-skew-occurs-when-the-distribution-of-the-training-dataset-is-significantly-different-from-the-distribution-of-the-serving-dataset-and-is-typically-caused-by-check-all-that-apply)
    - [TensorFlow Data Validation (TFDV) helps TFX users maintain the health of their ML pipelines. TFDV can analyze training and serves data to:](#tensorflow-data-validation-tfdv-helps-tfx-users-maintain-the-health-of-their-ml-pipelines-tfdv-can-analyze-training-and-serves-data-to)
  - [References](#references)

## Importance of data

https://imgur.com/a/5lmp12r

![imp1](https://i.imgur.com/RfzmSJ8.png)

![mlcode](https://i.imgur.com/623ogrg.png)

## Academia VS Production

 Over time, real-world data continuously changes, which can result in a degradation of your model performance. You need to continuously monitor the performance of your model, and if you measure a drop in performance, you need to go back to model retraining and tuning, or revise your data. During deployment, new data may affect your project design either positively or negatively and risk coping might be necessary. Ultimately, all these steps create your production ML system, which needs to run automatically such that you're continuously monitoring your model performance, ingesting new data, and retraining as needed, and then redeploying to maintain or improve your performance.

![ap1](https://i.imgur.com/hGJSLX4.png)

![ap2](https://i.imgur.com/q0Gzjlw.png0)

![ap3](https://i.imgur.com/MqtbDqM.png)

![ap4](https://i.imgur.com/MoxXOE2.png)

![ap5](https://i.imgur.com/7TDoYe2.png)

![ap6](https://i.imgur.com/RItJbvq.png)

## DAGs

![dag1](https://i.imgur.com/COjvCVl.png)

![dag2](https://i.imgur.com/825RcfC.png)

## TF Extended

![tfx1](https://i.imgur.com/ODQKsVH.png)

![tfx2](https://i.imgur.com/xAFoZrt.png)

![tfx3](https://i.imgur.com/krgpBCp.png)

##  Key Considerations

![kk](https://i.imgur.com/p0pYGoY.png)

![kk2](https://i.imgur.com/DaEgiMQ.png)

Some of the ways that ML Systems can fail are through things like representational harm. So representational harm is where a system will amplify or reflect a negative stereotype about particular groups. Opportunity denial is when a system makes predictions that have negative real life consequences that could result in lasting impacts. Disproportionate product failure is where the effectiveness of your model is really skewed so that the outputs happen more frequently for particular groups of users, you get skewed outputs more frequently essentially can think of as errors more frequently. Harm by disadvantage is where a system will infer disadvantageous associations between different demographic characteristics and the user behaviors around that.

![kk3](https://i.imgur.com/itDidPF.png)

![kk4](https://i.imgur.com/PpEOKBO.png)

Concept drift is a change in the statistical properties of the labels over time. At training, an ML model learns a mapping between the features and the labels. In a static world that's fine, that won't change. But in real-world, distribution and the labels meaning will change. The model needs to change as well as the mapping found during training will no longer be valid.

## Questions to take in consideration

![qq1](https://i.imgur.com/J4MiHSH.png)

![qq2](https://i.imgur.com/CT89HHQ.png)

![qq3](https://i.imgur.com/KwHDDPk.png)

## Slow and Fast drifts

![ssfd10](https://i.imgur.com/g0T9xj3.png)

![ssfd2](https://i.imgur.com/VTPXo3R.png)

![ssfd3](https://i.imgur.com/QhseIoY.png)

![ssfd4](https://i.imgur.com/XY9P7a4.png)

![ssfd5](https://i.imgur.com/FZNJt5f.png)

## Process feedback

![pf1](https://i.imgur.com/P8cl609.png)

![pf2](https://i.imgur.com/046kDhT.png)

## ML lines

![mll1](https://i.imgur.com/jCUieZq.png)

## Detecting data issues

![ddi1](https://i.imgur.com/jdl67Bv.png)

![ddi2](https://i.imgur.com/Ci9bmCk.png)

Dataset shift occurs when the joint probability of x are features and y are labels is not the same during training and serving. The data has shifted over time. Covariate shift refers to the change in distribution of the input variables present in training and serving data. In other words, it's where the marginal distribution of x are features is not the same during training and serving, but the conditional distribution remains unchanged. Concept shift refers to a change in the relationship between the input and output variables as opposed to the differences in the Data Distribution or input itself. In other words, it's when the conditional distribution of y are labels given x are features is not the same during training and serving, but the marginal distribution of x are features remains unchanged.

![ddiflow1](https://i.imgur.com/HEQMAm1.png)

![ddiflow2](https://i.imgur.com/sCWb3NA.png)

### Types of skews

![skew1](https://i.imgur.com/WWQ1tvg.png)

![skew2](https://i.imgur.com/NvKE4Ux.png)

![skew3](https://i.imgur.com/ap3Ips4.png)

![skew4](https://i.imgur.com/9bt1qjt.png)

## Summary

![summary](https://i.imgur.com/F09Eqvx.png)

## Quiz 1 - Intro to MLEP

### Static datasets are used for production ML modeling.
1 point

* False

### In production ML, the design priority is fast training.
1 point


* No

### Developers adhere to modern software development to produce low-maintenance software, and to address project evolution. Select all the key aspects of modern software development (Check all that apply):

* Testability

* Best practices

* Monitoring

### Model-performance needs to be continuously monitored, and new data, ingested and re-trained.
1 point

* Yes

### ML pipeline workflows are almost always DAGs.
1 point

* True

### TensorFlow Extended (TFX) is an end-to-end platform for deploying production ML pipelines.
1 point

* Yes

### Production machine learning combines which two key disciplines?
1 point

* Machine learning development

* Modern software development


### What are the unique challenges to overcome in a production-grade ML system? (Check all that apply)
1 point

* Building integrated ML systems.

* Continually operating while in production.

* Optimizing computational resources and costs.

* Handling continuously changing data.

### Production grade machine learning challenges are addressed by implementing an important concept:
1 point

* Machine learning pipelines

### TensorFlow Lite is a deep learning framework to deploy TFX pipelines into:
1 point

* Mobile devices

## Quiz 2 - Data Collection


### In ML, data are first-class citizens?
1 / 1 point

* Yes
Correct

Just right! Data are entities that support all operations generally available to other entities.

### A data pipeline is a series of data processing steps such as:
1 / 1 point

* Data collection
Correct

Way to go! Data collection is the first step in building ML systems.

* Data ingestion
Correct

Right on track! Data ingestion is the process of absorbing data from different sources and transferring it to a target site where it can be deposited and analyzed.

* Data Preparation
Correct

You’ve got it! Data Preparation consists of data formatting, engineering and feature extraction.

### Is the Data pipeline vital for the success of the production ML system?
1 / 1 point

* Yes
Correct

 Exactly! It consists of the incredibly important steps to the production ML system success.

### What do you apply to maximize predictive signals in your data?
1 / 1 point

* Feature engineering

Correct

You’ve figured it out! Feature engineering is the process of using domain knowledge to extract features with high levels of predictive signal from raw data.

### Your training data should reflect the diversity and cultural context of the people who will use it. What can be done to mitigate inherent biases in a given data set?
1 / 1 point

* Collect data from equal proportions from different user groups.

Excellent! Balanced sampling from different user groups helps avoid inherent biases.

### More often than not,  ML systems can fail the users it serves. In this context, what is representational harm?
1 / 1 point

* The amplification or negative reflection of certain groups stereotypes.

Inferring prejudicial links between certain demographic traits and user behaviors.
Correct

Good call! This is a prototypical way an ML system may fail the users it serves.

### Accurate labels are necessary to properly train supervised models. Many times, human subjects known as raters perform this labeling effort. What are the main categories of human raters? (check all that apply). 
1 / 1 point

* Generalists
Correct

Good choice! Generalists usually come from crowdsourcing sites.

* Subject matter experts
Correct

Nice going!. A classical example is radiologists labeling medical images for automated diagnosis tools.

* Your users
Correct

Right choice! Users can provide labels within your application. A classical example is photo tagging.

## Quiz 3 - Data Labeling

### Which factors substantially complicate production machine learning? (Check all that apply)
0.75 / 1 point

* Ground truth that changes slowly 
This should not be selected

It’s the other way around actually. This situation would not be particularly difficult to handle in production.

* Labeling through Weak Supervision
Correct

Nicely done! 

* Model Retraining driven by declining model performance.
Correct

Right choice! 

### Direct Labeling is one of the methods used in production ML to label data. About it we can say that: 
1 / 1 point

* It captures strong label signals
Correct

That’s correct!

* It needs to match prediction results with their corresponding original inference request.
Correct

That’s right! Feature selection identifies features with predictive power.

### A cardiologist labeling MRI images is a typical example of Direct Labeling.
1 / 1 point

* False
Correct

Great job! MRI labeling by a medical specialist is an example of Human Labeling

### Quiz 4 - Issues in Training Data

### What formula represents a dataset shift?
1 / 1 point

* Ptrain(y|x)≠Pserve(y|x) and Ptrain(x)=Pserve(x)

Well done! The most generic case of distribution skews is when the joint distribution of inputs and outputs differs between training and serving.

### What measure is typically used to determine the degree of data drift?
1 / 1 point

* Chebyshev distance (L-infinity)
Correct

That’s it! Chebyshev distance is defined as maxi(|xi−yi|)

### Distribution skew occurs when the distribution of the training dataset is significantly different from the distribution of the serving dataset, and is typically caused by: (check all that apply). 
1 / 1 point


* Faulty sampling method that selects a sample for training which is not representative of serving data distribution.
Correct

Spot on! A faulty sampling mechanism that chooses a non-representative subsample is an example of distribution skew.

* Different data sources for training and serving data.
Correct

Way to go! Data sources between training and serving often change and so this is another case of distribution skew.

* Trend, seasonality, changes in data over time.
Correct

Keep it up! Data distributions between training and serving often change and so this is another case of distribution skew.


### TensorFlow Data Validation (TFDV) helps TFX users maintain the health of their ML pipelines. TFDV can analyze training and serves data to:
1 / 1 point

* Compute descriptive statistics.
Correct

Perfect! TFDV goes beyond computing relevant statistics, it also has nice browser-based visualization tools.

* Infer a schema.
Correct

 Nice going! In short, schemas describe the expectations for "correct" data and can thus be used to detect errors in the data.

* Detect data anomalies.
Correct

That’s the way! TFDV can check your data for error in the aggregate across an entire dataset or by checking for errors on a per-example basis.

## References

[Announcing the CD Foundation MLOps SIG](https://cd.foundation/blog/2020/02/11/announcing-the-cd-foundation-mlops-sig/)

----

[Software 2.0](https://karpathy.medium.com/software-2-0-a64152b37c35)

----

Paleyes, A., Urma, R.-G., & Lawrence, N. D. (2020). Challenges in deploying machine learning: A survey of case studies. http://arxiv.org/abs/2011.09926

----

Sculley, D., Holt, G., Golovin, D., Davydov, E., & Phillips, T. (n.d.). Hidden technical debt in machine learning systems. Retrieved April 28, 2021, from Nips.cc https://papers.nips.cc/paper/2015/file/86df7dcfd896fcaf2674f757a2463eba-Paper.pdf
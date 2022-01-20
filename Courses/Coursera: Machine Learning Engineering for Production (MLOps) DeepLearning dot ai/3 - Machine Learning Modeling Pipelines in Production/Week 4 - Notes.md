# Use model performance analysis to debug and remediate your model and measure robustness, fairness, and stability.

- [Use model performance analysis to debug and remediate your model and measure robustness, fairness, and stability.](#use-model-performance-analysis-to-debug-and-remediate-your-model-and-measure-robustness-fairness-and-stability)
  - [Model performance](#model-performance)
  - [TensorFlow Model Analysis](#tensorflow-model-analysis)
    - [Example code](#example-code)
  - [Debugging and benchmarking](#debugging-and-benchmarking)
    - [Types of attacks](#types-of-attacks)
  - [Analysis](#analysis)
  - [Remediation techniques](#remediation-techniques)
  - [Fairness](#fairness)
  - [Continuous Evaluation](#continuous-evaluation)
    - [Unsupervised](#unsupervised)
    - [Supervised](#supervised)
  - [Resources](#resources)
  - [Lab](#lab)
  - [Quiz 1 - Model Analysis](#quiz-1---model-analysis)
    - [In many instances it is necessary to understand how the model is working internally. This is very useful when you are experimenting with new architectures to understand how data is flowing internally within each layer of the model. This can help you adjust and iterate on your model architecture to improve performance and efficiency. Which of the following is a correct approach to understand the inner workings of a given model?](#in-many-instances-it-is-necessary-to-understand-how-the-model-is-working-internally-this-is-very-useful-when-you-are-experimenting-with-new-architectures-to-understand-how-data-is-flowing-internally-within-each-layer-of-the-model-this-can-help-you-adjust-and-iterate-on-your-model-architecture-to-improve-performance-and-efficiency-which-of-the-following-is-a-correct-approach-to-understand-the-inner-workings-of-a-given-model)
    - [TensorBoard is an example of a tool for black-box evaluation.](#tensorboard-is-an-example-of-a-tool-for-black-box-evaluation)
    - [Performance metrics are independent of the kind of task done.](#performance-metrics-are-independent-of-the-kind-of-task-done)
  - [Quiz 2 - Model Analysis and Debugging](#quiz-2---model-analysis-and-debugging)
    - [When evaluating an ML model during training the goal is to improve top-level metrics such as overall accuracy. This information is used to decide whether the model is doing well or not, but it doesn't show how well it does on individual parts of the data. Which technique is extremely helpful to address this shortcoming?](#when-evaluating-an-ml-model-during-training-the-goal-is-to-improve-top-level-metrics-such-as-overall-accuracy-this-information-is-used-to-decide-whether-the-model-is-doing-well-or-not-but-it-doesnt-show-how-well-it-does-on-individual-parts-of-the-data-which-technique-is-extremely-helpful-to-address-this-shortcoming)
    - [Streaming metrics are approximations to full-pass performance metrics computed on __________.](#streaming-metrics-are-approximations-to-full-pass-performance-metrics-computed-on-__________)
    - [A recent credit card loyalty program offered by a big technology company has been labeled as “sexist”, a clear example of algorithm based social discrimination. Let’s examine a user complaint on Twitter: “My wife and I filed joint tax returns, live in a community-property state, and have been married for a long time. Yet the black box algorithm thinks I deserve 20x the credit limit she does. No appeals work.” These and other similar claims have triggered a full-blown investigation by the New York State Department of Financial Services. Which of the reviewed techniques in lecture could have been implemented to prevent this embarrassing problem?](#a-recent-credit-card-loyalty-program-offered-by-a-big-technology-company-has-been-labeled-as-sexist-a-clear-example-of-algorithm-based-social-discrimination-lets-examine-a-user-complaint-on-twitter-my-wife-and-i-filed-joint-tax-returns-live-in-a-community-property-state-and-have-been-married-for-a-long-time-yet-the-black-box-algorithm-thinks-i-deserve-20x-the-credit-limit-she-does-no-appeals-work-these-and-other-similar-claims-have-triggered-a-full-blown-investigation-by-the-new-york-state-department-of-financial-services-which-of-the-reviewed-techniques-in-lecture-could-have-been-implemented-to-prevent-this-embarrassing-problem)
    - [State of the art convolutional neural networks can be fooled to misclassify craftily noise corrupted images with changes that are completely imperceptible to the human eye, as illustrated by the following picture:](#state-of-the-art-convolutional-neural-networks-can-be-fooled-to-misclassify-craftily-noise-corrupted-images-with-changes-that-are-completely-imperceptible-to-the-human-eye-as-illustrated-by-the-following-picture)
    - [A performance-metric gap between two or more groups could be a sign that an ML model may have unfair skews. Therefore, is achieving performance equality (on fairness indicators) across groups a definite sign that a model is fair?](#a-performance-metric-gap-between-two-or-more-groups-could-be-a-sign-that-an-ml-model-may-have-unfair-skews-therefore-is-achieving-performance-equality-on-fairness-indicators-across-groups-a-definite-sign-that-a-model-is-fair)
    - [After a model has been deployed, is it usually feasible to perform residual analysis?](#after-a-model-has-been-deployed-is-it-usually-feasible-to-perform-residual-analysis)

## Model performance

![mp1](https://i.imgur.com/YZn42uZ.png)

![mp2](https://i.imgur.com/Dtzt3JN.png)

![mp3](https://i.imgur.com/Dtzt3JN.png)

## TensorFlow Model Analysis

![tfma1](https://i.imgur.com/kxfmrTU.png)

![tfma2](https://i.imgur.com/2RcqD7R.png)

![tfma3](https://i.imgur.com/HaFV8dh.png)

he TFMA pipeline is made up of four main components. Read inputs, extractors, evaluators, and write results. The first stage read input is made up of a transform that takes raw inputs such as CSV or TF records and so forth and it converts it into a dictionary format which is understandable by the next stage, extraction. Across all the stages, the output is kept in this dictionary format, which is at the datatype tfma.extracts. The next stage, extraction performs distributed processing using Apache Beam. Input extractor and slice key extractor for slices of the original dataset, which will be used by predict extractor to run predictions on each slice. The results are sent to the next stage, again, as a tfma.extracts dictionary. The next stage evaluation also performs distributed processing using Apache Beam. There are several evaluators and you can create custom evaluators as well. For example, the metrics and plots evaluator extracts the required fields from the data to evaluate the performance of the model against the received predictions from the previous stage. The final stage, write results, as the name suggests, writes the results to disk.

![tfma4](https://i.imgur.com/ytLClRa.png)

![tfma5](https://i.imgur.com/YlcE6zc.png)

![tfma6](https://i.imgur.com/9eICeo4.png)

### Example code

![tfmae1](https://i.imgur.com/eMc7Awt.png)

![tfmae2](https://i.imgur.com/MfgC3RY.png)

![tfma3](https://i.imgur.com/lQbxyJB.png)

![tfma4](https://i.imgur.com/0MwYO8A.png)

## Debugging and benchmarking

![d1](https://i.imgur.com/tEWA7Ig.png)

![d2](https://i.imgur.com/OrR5N2O.png)

![d3](https://i.imgur.com/pDBPH9L.png)

### Types of attacks

![ta1](https://i.imgur.com/CnEAuiq.png)

![ta2](https://i.imgur.com/5RW33o7.png)

![ta3](https://i.imgur.com/F6MvSSq.png)

![ta4](https://i.imgur.com/45rBkse.png)

![ta5](https://i.imgur.com/k8Az0pB.png)

## Analysis

![a1](https://i.imgur.com/XyBmmeY.png)

![a2](https://i.imgur.com/jFjVicn.png)

## Remediation techniques

![rt1](https://i.imgur.com/1J1fPhp.png)

![rt2](https://i.imgur.com/VvsW7Cl.png)

![rt3](https://i.imgur.com/cyxADwe.png)

## Fairness

![f1](https://i.imgur.com/sIbg9FC.png)

![f2](https://i.imgur.com/LBQncyJ.png)

![f3](https://i.imgur.com/p6xuv5J.png)

![f4](https://i.imgur.com/Fljo9eZ.png)

Pay special attention to slices of data that deal with sensitive characteristics such as race, ethnicity, gender, nationality, incomes, sexual orientation, and disability status. Ideally, you should be working with labeled data. But if not, then you can apply statistics to look at the distributions of the outcomes with some assumptions around any expected differences.

![f5](https://i.imgur.com/p08aPL9.png)

## Continuous Evaluation

### Unsupervised

![CE1](https://i.imgur.com/2rVj48S.png)

![CE2](https://i.imgur.com/5V7GESl.png)

![CE3](https://i.imgur.com/iMWza9C.png)

### Supervised

![CE4](https://i.imgur.com/Kemw2po.png)

![CE5](https://i.imgur.com/br0mhiK.png)

![CE6](https://i.imgur.com/35VdZMt.png)

## Resources

https://blog.tensorflow.org/2018/03/introducing-tensorflow-model-analysis.html

https://www.infoq.com/presentations/instrumentation-observability-monitoring-ml/

https://christophergs.com/machine%20learning/2020/03/14/how-to-monitor-machine-learning-models/


## Lab 

https://googlecoursera.qwiklabs.com/focuses/19780872?parent=lti_session

https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/quests/dei/xgboost_caip_e2e.ipynb

## Quiz 1 - Model Analysis

### In many instances it is necessary to understand how the model is working internally. This is very useful when you are experimenting with new architectures to understand how data is flowing internally within each layer of the model. This can help you adjust and iterate on your model architecture to improve performance and efficiency. Which of the following is a correct approach to understand the inner workings of a given model?
1 / 1 point

* Model introspection

Correct

!!! note That’s right! Model introspection for example will allow you to elucidate which data points activate certain layers of the mode and then adjust your design based on these observations.

### TensorBoard is an example of a tool for black-box evaluation.
1 / 1 point

* True
Correct

!!! note Well done! TensorBoard can monitor the loss and accuracy of every iteration of the model.

### Performance metrics are independent of the kind of task done.
1 / 1 point

* False
Correct

!!! note Good job! They will be different for different types of tasks like classification, regression, etc.

## Quiz 2 - Model Analysis and Debugging

### When evaluating an ML model during training the goal is to improve top-level metrics such as overall accuracy. This information is used to decide whether the model is doing well or not, but it doesn't show how well it does on individual parts of the data. Which technique is extremely helpful to address this shortcoming?
1 / 1 point

* Data Slicing
Correct

!!! note That’s right! Slicing deals with understanding how a model is performing on each subset of data.

### Streaming metrics are approximations to full-pass performance metrics computed on __________. 
1 / 1 point

* mini-batches of data
Correct

!!! note That’s right! This is a nice way to approximate the full-pass metrics without incurring a huge computational overhead cost.

### A recent credit card loyalty program offered by a big technology company has been labeled as “sexist”, a clear example of algorithm based social discrimination. Let’s examine a user complaint on Twitter: “My wife and I filed joint tax returns, live in a community-property state, and have been married for a long time. Yet the black box algorithm thinks I deserve 20x the credit limit she does. No appeals work.” These and other similar claims have triggered a full-blown investigation by the New York State Department of Financial Services. Which of the reviewed techniques in lecture could have been implemented to prevent this embarrassing problem?
1 / 1 point

* Model debugging
Correct

!!! note That’s right! Model debugging tries to improve the transparency of models by highlighting how data is flowing inside and thus can prevent harmful social discrimination.

### State of the art convolutional neural networks can be fooled to misclassify craftily noise corrupted images with changes that are completely imperceptible to the human eye, as illustrated by the following picture:
![img1](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/zPkkm5MHQRK5JJuTB0ESXQ_d0ebd2b118c34f1baf39b8d039d26cf1_quizz_c3_w4.png?expiry=1642809600000&hmac=IkMIRLqaVymG30Qn17HT_3DGVNeCLTNBXIQFK7-yXMk)

What type of analysis can help us detect and prevent these types of scenarios?
1 / 1 point

* Sensitivity analysis
Correct

!!! note That’s right! Sensitivity analysis helps with understanding a model by examining the impact that each feature has on the model’s prediction. In sensitivity analysis we experiment by changing a feature value while holding the other features constant, and observe the model results. 

### A performance-metric gap between two or more groups could be a sign that an ML model may have unfair skews. Therefore, is achieving performance equality (on fairness indicators) across groups a definite sign that a model is fair?
1 / 1 point

* No
Correct

!!! note That’s right! Systems are highly complex and achieving equality on one, or even all of the provided metrics can’t guarantee fairness. Fairness evaluations should be run throughout the development process and post-launch as well.

### After a model has been deployed, is it usually feasible to perform residual analysis?
1 / 1 point

* No
Correct

!!! note That’s right! Once your model is deployed, you may not have a good amount of labeled data and consequently, residual analysis can prove to be a costly exercise as it might include you hiring workers to label your incoming test data.
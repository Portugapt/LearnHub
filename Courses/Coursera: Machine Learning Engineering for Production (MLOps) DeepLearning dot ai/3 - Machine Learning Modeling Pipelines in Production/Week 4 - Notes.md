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
  - [Course resources](#course-resources)

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

## Course resources

Overall resources:

Towards ML Engineering - History of TFX: 

https://arxiv.org/abs/2010.02013

Challenges in Deploying ML:

https://arxiv.org/abs/2011.09926
Week 1: Neural Architecture Search

Neural Architecture Search:

https://arxiv.org/pdf/1808.05377.pdf

Bayesian Optimization:

https://distill.pub/2020/bayesian-optimization/

Neural Architecture Search with Reinforcement Learning:

https://arxiv.org/pdf/1611.01578.pdf

Progressive Neural Architecture Search:

https://arxiv.org/pdf/1712.00559.pdf

Network Morphism:

https://arxiv.org/abs/1603.01670

Amazon SageMaker Autopilot

https://aws.amazon.com/sagemaker/autopilot

Microsoft Azure Automated Machine Learning

https://azure.microsoft.com/en-in/services/machine-learning/automatedml/

Google Cloud AutoML

https://cloud.google.com/automl
Week 2: Model Resource Management Techniques

High dimensional spaces visualization:

https://colab.research.google.com/drive/1GTBYAcMsiKDDQeDpyOIi_DGuPVleJAf0?usp=sharing

Word embeddings:

https://heartbeat.fritz.ai/coreml-with-glove-word-embedding-and-recursive-neural-network-part-2-d72c1a66b028

Curse of dimensionality:

https://builtin.com/data-science/curse-dimensionality

https://www.visiondummy.com/2014/04/curse-dimensionality-affect-classification/

Sparsity:

https://www.kdd.org/exploration_files/parsons.pdf

Feature engineering:

https://quantdare.com/what-is-the-difference-between-feature-extraction-and-feature-selection/

https://machinelearningmastery.com/discover-feature-engineering-how-to-engineer-features-and-how-to-get-good-at-it/

PCA:

https://scikit-learn.org/stable/modules/decomposition.html

https://www.coursera.org/lecture/machine-learning/principal-component-analysis-problem-formulation-GBFTt

https://stats.stackexchange.com/questions/2691/making-sense-of-principal-component-analysis-eigenvectors-eigenvalues/140579#140579

https://elitedatascience.com/dimensionality-reduction-algorithms

ICA:

https://scikit-learn.org/stable/modules/decomposition.html

https://scikit-learn.org/stable/auto_examples/decomposition/plot_ica_vs_pca.html

NMF:

https://scikit-learn.org/stable/modules/decomposition.html#non-negative-matrix-factorization-nmf-or-nnmf

Mobile model deployment:

https://developers.google.com/ml-kit

https://www.tensorflow.org/lite

Quantization:

https://www.qualcomm.com/news/onq/2019/03/12/heres-why-quantization-matters-ai

https://petewarden.com/2016/05/03/how-to-quantize-neural-networks-with-tensorflow/

https://arxiv.org/abs/1712.05877

https://blog.tensorflow.org/2020/04/quantization-aware-training-with-tensorflow-model-optimization-toolkit.html

https://www.tensorflow.org/lite/performance/best_practices

Post-training quantization:

https://medium.com/tensorflow/introducing-the-model-optimization-toolkit-for-tensorflow-254aca1ba0a3

Quantization aware training:

https://blog.tensorflow.org/2020/04/quantization-aware-training-with-tensorflow-model-optimization-toolkit.html

Pruning:

https://blog.tensorflow.org/2019/05/tf-model-optimization-toolkit-pruning-API.html

http://yann.lecun.com/exdb/publis/pdf/lecun-90b.pdf

https://towardsdatascience.com/can-you-remove-99-of-a-neural-network-without-losing-accuracy-915b1fab873b

https://arxiv.org/abs/1803.03635

https://numenta.com/blog/2019/08/30/case-for-sparsity-in-neural-networks-part-1-pruning

https://www.tensorflow.org/model_optimization/guide/pruning
Week 3: High Performance Modeling

Distribution strategies:

https://www.tensorflow.org/guide/distributed_training

Changes in data parallelism:

https://arxiv.org/abs/1806.03377

Pipeline parallelism:

https://ai.googleblog.com/2019/03/introducing-gpipe-open-source-library.html

GPipe:

https://github.com/tensorflow/lingvo/blob/master/lingvo/core/gpipe.py

https://arxiv.org/abs/1811.06965

GoogleNet:

https://arxiv.org/abs/1409.4842

Knowledge distillation:

https://ai.googleblog.com/2018/05/custom-on-device-ml-models.html

https://arxiv.org/pdf/1503.02531.pdf

https://nervanasystems.github.io/distiller/knowledge_distillation.html

DistilBERT:

https://blog.tensorflow.org/2020/05/how-hugging-face-achieved-2x-performance-boost-question-answering.html

Two-stage multi-teacher distillation for Q & A:

https://arxiv.org/abs/1910.08381

EfficientNets:

https://arxiv.org/abs/1911.04252
Week 4: Model Performance Analysis

TensorBoard:

https://blog.tensorflow.org/2019/12/introducing-tensorboarddev-new-way-to.html

Model Introspection:

https://www.kaggle.com/c/dogs-vs-cats/data

Optimization process:

https://cs231n.github.io/neural-networks-3/

TFMA architecture:

https://www.tensorflow.org/tfx/model_analysis/architecture

TFMA:

https://blog.tensorflow.org/2018/03/introducing-tensorflow-model-analysis.html

Aggregate versus slice metrics:

https://blog.tensorflow.org/2018/03/introducing-tensorflow-model-analysis.html

What-if tool:

https://pair-code.github.io/what-if-tool/

https://www.google.com/url?q=https://www.youtube.com/playlist?list%3DPLIivdWyY5sqK7Z5A2-sftWLlbVSXuyclr&sa=D&source=editors&ust=1620676474220000&usg=AFQjCNEF_ONMs8YkdUtgUp2-stfKmDdWtA

Partial Dependence Plots:

https://github.com/SauceCat/PDPbox

https://github.com/AustinRochford/PyCEbox

Adversarial attacks:

http://karpathy.github.io/2015/03/30/breaking-convnets/

https://arxiv.org/pdf/1707.08945.pdf

Informational and behavioral harms:

https://fpf.org/wp-content/uploads/2019/09/FPF_WarningSigns_Report.pdf

Clever Hans:

https://github.com/cleverhans-lab/cleverhans

Foolbox:

https://foolbox.jonasrauber.de/

Defensive distillation:

https://arxiv.org/abs/1511.04508

Concept Drift detection for Unsupervised Learning: 

https://arxiv.org/pdf/1704.00023.pdf

Cloud providers:

https://cloud.google.com/ai-platform/prediction/docs/continuous-evaluation

https://aws.amazon.com/sagemaker/model-monitor

https://docs.microsoft.com/en-us/azure/machine-learning/how-to-monitor-datasets

Fairness:

https://www.tensorflow.org/responsible_ai/fairness_indicators/guide

Model Remediation: 

https://www.tensorflow.org/responsible_ai/model_remediation

AIF360:

http://aif360.mybluemix.net/

Themis ML:

https://github.com/cosmicBboy/themis-ml

LFR: 

https://arxiv.org/pdf/1904.13341.pdf
Week 5: Explainability

Fooling DNNs:

https://arxiv.org/pdf/1607.02533.pdf

https://arxiv.org/pdf/1412.6572.pdf

XAI:

http://www.cs.columbia.edu/~orb/papers/xai_survey_paper_2017.pdf

Interpretable models

https://christophm.github.io/interpretable-ml-book/

https://www.tensorflow.org/lattice

Dol bear law:

https://en.wikipedia.org/wiki/Dolbear%27s_law

TensorFlow Lattice:

https://www.tensorflow.org/lattice

https://jmlr.org/papers/volume17/15-243/15-243.pdf

PDP: 

https://github.com/SauceCat/PDPbox

https://scikit-learn.org/stable/auto_examples/inspection/plot_partial_dependence.html

Permutation Feature Importance:

http://arxiv.org/abs/1801.01489

Shapley values:

https://en.wikipedia.org/wiki/Shapley_value

SHAP:

https://github.com/slundberg/shap

 TCAV:

https://arxiv.org/pdf/1711.11279.pdf

 LIME:

https://github.com/marcotcr/lime

Google Cloud XAI

https://storage.googleapis.com/cloud-ai-whitepapers/AI%20Explainability%20Whitepaper.pdf

Integrated gradients:

https://arxiv.org/pdf/1703.01365.pdf



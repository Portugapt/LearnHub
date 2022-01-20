# Feature Engineering and Selection

- [Feature Engineering and Selection](#feature-engineering-and-selection)
  - [Why?](#why)
  - [Techniques](#techniques)
  - [Feature Crosses](#feature-crosses)
  - [Pre-processing at scale](#pre-processing-at-scale)
  - [TF Transform](#tf-transform)
  - [TF transform hello world](#tf-transform-hello-world)
    - [ExampleGen](#examplegen)
  - [Feature Selection](#feature-selection)
    - [Feature Space](#feature-space)
    - [Why Feature selection?](#why-feature-selection)
    - [Unsupervised](#unsupervised)
    - [Supervised](#supervised)
      - [Filter methods](#filter-methods)
      - [Wrapper methods](#wrapper-methods)
      - [Embedded Methods](#embedded-methods)
  - [References](#references)
  - [Quiz 1 - Feature Engineering and Preprocessing](#quiz-1---feature-engineering-and-preprocessing)
    - [In the mapping of categorical values, can models directly multiply strings by the learned weights?](#in-the-mapping-of-categorical-values-can-models-directly-multiply-strings-by-the-learned-weights)
    - [Feature engineering can be applied before modeling or be part of the model on the input stage. Regarding Feature Engineering, we can say that: (Only one correct answer).](#feature-engineering-can-be-applied-before-modeling-or-be-part-of-the-model-on-the-input-stage-regarding-feature-engineering-we-can-say-that-only-one-correct-answer)
    - [Which of the following is not considered a feature engineering inconsistency:](#which-of-the-following-is-not-considered-a-feature-engineering-inconsistency)
  - [Quiz 2 - Feature Transformation](#quiz-2---feature-transformation)
    - [Transformation operations can happen at the instance level or be applied to the entire dataset. Which one is an instance-level transformation?](#transformation-operations-can-happen-at-the-instance-level-or-be-applied-to-the-entire-dataset-which-one-is-an-instance-level-transformation)
    - [In a pre-processing training dataset, all transformations that are carried out must be done in the serving set:](#in-a-pre-processing-training-dataset-all-transformations-that-are-carried-out-must-be-done-in-the-serving-set)
    - [What statement is true about TensorFlow Transform?](#what-statement-is-true-about-tensorflow-transform)
  - [Quiz 3 - Feature Selection](#quiz-3---feature-selection)
    - [Consider a binary classification problem in a 2D  feature space. What is the shape of the boundary separating the 2 classes in an ideal setting?](#consider-a-binary-classification-problem-in-a-2d--feature-space-what-is-the-shape-of-the-boundary-separating-the-2-classes-in-an-ideal-setting)
    - [Feature selection is characterized by: (check all that apply).](#feature-selection-is-characterized-by-check-all-that-apply)
    - [What is the definition of backward elimination?](#what-is-the-definition-of-backward-elimination)
    - [Embedded methods combine the best of both worlds, filter and wrapper methods. Embedded methods are: (Check all that apply)](#embedded-methods-combine-the-best-of-both-worlds-filter-and-wrapper-methods-embedded-methods-are-check-all-that-apply)

https://imgur.com/a/CcG8ssG

## Why? 

![why1](https://i.imgur.com/vMbzxd4.png)

![why2](https://i.imgur.com/rTIvL7p.png)

One of the most important Preprocessing Operations is Data cleansing, which in broad terms consists in eliminating or correcting erroneous data. You'll often need to perform transformations on your data, so scaling or normalizing your numeric values, for example. Since models, especially neural networks, are sensitive to the amplitude or range of numerical features, data preprocessing helps Machine Learning build better predictive Models. Dimensionality reduction involves reducing the number of features by creating lower dimension and more robust data represents. Feature construction can be used to create new features by using several different techniques, which we'll talk about some of them. This is an example of data that we have. We're looking at a house. This is data from a house, but this is only what we start with. The raw data. Feature Engineering because it's in performing an analysis of the raw data and then creating a feature vector from it.

![why3](https://i.imgur.com/acaDNvF.png)

It's difficult to pass from a training to serving aspect the engineered features. And a lot of problems are show up if this is not correctly done.

![why4](https://i.imgur.com/itmYUwE.png)


## Techniques

![t1](https://i.imgur.com/yx9OhvL.png)

![t2](https://i.imgur.com/GMkMceC.png)

* Normalization

* Standardization (z-score)

* Bucketizing / Binning

![buckets](https://i.imgur.com/eOexbe7.png)

Binning with Facets

* PCA 
* t-SNE
* UMAP

Can use an embedding projector:
* Intuitive exporative of high-dimensional data

![t3](https://i.imgur.com/GMkMceC.png)

![t4](https://i.imgur.com/1ae0Wxy.png)

## Feature Crosses

![fc1](https://i.imgur.com/EE2P9a5.png)

![fc2](https://i.imgur.com/5P3BYVk.png)

## Pre-processing at scale

![outline1](https://i.imgur.com/RkFwJ3M.png)

![pps1](https://i.imgur.com/Q1lvywW.png)

![mlpipe1](https://i.imgur.com/TsHGxTa.png)

![pipes2](https://i.imgur.com/Lc9rZ7p.png)

![pipes3](https://i.imgur.com/tl9jbmT.png)

I have the whole dataset so I can do a full pass, although it can be expensive to do that. At serving time, I get individual examples, so I can only really do instance level. So anything I need to do that requires characteristics of the whole dataset.

![pipes4](https://i.imgur.com/Raybxqr.png)

![pipes5](https://i.imgur.com/ExyvR5w.png)

So you may have say GPUs or TPUs when you're training, you may not when you're serving. So there's long model latency, that's when you're serving your model, if you're doing a lot of transformation with it that can slow down the response time for your model and increase latency. And, you can have transformations per batch that that skew that we talked about. If you haven't saved those constants that you need, that could be an issue. You can also transform per batch instead of for the entire dataset.

![pipes6](https://i.imgur.com/iWzbz5s.png)

![pipes7](https://i.imgur.com/9BevpXh.png)

![pipes8](https://i.imgur.com/xQE3F24.png)

## TF Transform

![outline2](https://i.imgur.com/z6olcyg.png)

![mlpipe1](https://i.imgur.com/TsHGxTa.png)

![tftransform1](https://i.imgur.com/TetOL47.png)

![tftransform2](https://i.imgur.com/p4Sxw0T.png)

![tfanalyzer1](https://i.imgur.com/grLqOlv.png)

We're going to use an analyzer to make that pass over the data and collect those constants. It's also going to express the operations that we're going to do. They behave like TensorFlow Ops, but they only were on once during training and then they're saved off as a graph. 

![tfanalyzer2](https://i.imgur.com/PgclpBk.png)

![tfanalyzer3](https://i.imgur.com/93Wyph0.png)

![analyzerframework](https://i.imgur.com/moiM6JU.png)

![tfanalyzercode1](https://i.imgur.com/pggnULN.png)

![tfanalyzercode2](https://i.imgur.com/VLTGZ3a.png)

## TF transform hello world

![hello1](https://i.imgur.com/pggnULN.png)

![hello2](https://i.imgur.com/VLTGZ3a.png)

![hello3](https://i.imgur.com/iH9xpB0.png)

![hello4](https://i.imgur.com/IvRAcmx.png)

![hello5](https://i.imgur.com/5bQHcPc.png)

![hello6](https://i.imgur.com/ecoRzXx.png)

![hello7](https://i.imgur.com/yPZYNkZ.png)

![hello8](https://i.imgur.com/BN8iYG6.png)

![hellokeys](https://i.imgur.com/Qnxkljd.png)

TensorFlow Ops: Any function that accepts and returns tensors. These add TensorFlow operations to the graph that transforms raw data into transformed data one feature vector at a time. These will run for every example, during both training and serving.

TensorFlow Transform Analyzers: Any of the analyzers provided by tf.Transform. Analyzers also accept and return tensors, but unlike TensorFlow ops they only run once during training, and typically make a full pass over the entire training dataset. They create tensor constants, which are added to your graph. For example, tft.min computes the minimum of a tensor over the training dataset.

### ExampleGen

```python
# Instantiate ExampleGen with the input CSV dataset
example_gen = tfx.components.CsvExampleGen(input_base=_data_root)

# Execute the component
context.run(example_gen)
```
You will notice that an output cell showing the execution results is automatically shown. This metadata is recorded into the database created earlier. This allows you to keep track of your project runs. For example, if you run it again, you will notice the .execution_id incrementing.

The output of the components are called artifacts and you can see an example by navigating through .component.outputs > ['examples'] > Channel > ._artifacts > [0] above. It shows information such as where the converted data is stored (.uri) and the splits generated (.split_names).

## Feature Selection

### Feature Space
![featurespace1](https://i.imgur.com/pMvwXHP.png)

![featurespace2](https://i.imgur.com/cCnhAf8.png)

![featurespace3](https://i.imgur.com/xZAoZxy.png)

![featurespace4](https://i.imgur.com/iFz08GN.png)

![featurespace5](https://i.imgur.com/mltghP2.png)

### Why Feature selection?

![fs1](https://i.imgur.com/px9ogMb.png)

### Unsupervised

![unsupervised1](https://i.imgur.com/EYg2g7X.png)

### Supervised

![supervised1](https://i.imgur.com/NZOpRi6.png)

![supervised2](https://i.imgur.com/DUs2ONb.png)

![supervised3](https://i.imgur.com/Bb6aWWB.png)

#### Filter methods



![filter1](https://i.imgur.com/i4pi591.png)

![filter2](https://i.imgur.com/3MWObDW.png)

![filter4](https://i.imgur.com/wrva213.png)

![filter3](https://i.imgur.com/1pPTq87.png)

![filter5](https://i.imgur.com/CfCI1uw.png)

![filter6](https://i.imgur.com/9XY1Ucq.png)

![filter7](https://i.imgur.com/VSRQ704.png)

#### Wrapper methods

![wrapper1](https://i.imgur.com/kz2Chce.png)

![wrapper2](https://i.imgur.com/zzQVqOf.png)

![wrapperforward](https://i.imgur.com/WXrgxAp.png)

![wrapperbackward](https://i.imgur.com/sMIAdU5.png)

![wrapperrfe](https://i.imgur.com/KTSTxRW.png)

![wrapperperf](https://i.imgur.com/Up63asJ.png)

#### Embedded Methods

![emb1](https://i.imgur.com/W2CIDA3.png)

![emb2](https://i.imgur.com/G7QOHSC.png)

![emb3](https://i.imgur.com/feOQJ8G.png)

![emb4](https://i.imgur.com/5NHEgzR.png)

![emb5](https://i.imgur.com/tP06h87.png)

![emb6](https://i.imgur.com/MGLBjmv.png)

## References

https://www.commonlounge.com/discussion/3ce75d036e924c70ab7e47f534ec40fc/history

## Quiz 1 - Feature Engineering and Preprocessing

### In the mapping of categorical values, can models directly multiply strings by the learned weights?
1 / 1 point

* No
Correct

Correct! Feature engineering must be  applied in advance  to convert strings into numerical values.

### Feature engineering can be applied before modeling or be part of the model on the input stage. Regarding Feature Engineering, we can say that: (Only one correct answer).
1 / 1 point

* Feature Engineering within the model is limited to batch computations.

Correct

Well done!

### Which of the following is not considered a feature engineering inconsistency:
1 / 1 point

* All transformations are the same in any scenario

Correct

Good job! It’s actually the other way around, this is pursued to reduce the risk of introducing skews.

## Quiz 2 - Feature Transformation

### Transformation operations can happen at the instance level or be applied to the entire dataset. Which one is an instance-level transformation?
1 / 1 point

* Feature Cross

Correct

You’ve got it right!

### In a pre-processing training dataset, all transformations that are carried out must be done in the serving set:
1 / 1 point

* True

Correct

Perfect! Also, this is considered a con, as it can produce slower iterations being less efficient than in the training.


###  What statement is true about TensorFlow Transform?
1 / 1 point


* TF Transform eliminates the risk of introducing training-serving skew
Correct

Good call! TF Transform uses the same code path for both training and serving.

## Quiz 3 - Feature Selection

### Consider a binary classification problem in a 2D  feature space. What is the shape of the boundary separating the 2 classes in an ideal setting?
1 / 1 point

* Linear

Correct

Exactly! This is the simplest functional form of a boundary.

### Feature selection is characterized by: (check all that apply).
1 / 1 point

* Identify features that best represent the relationship between two or more variables.
Correct

Good job! Feature selection identifies features with predictive power.

* Remove features that don’t influence the outcome.
Correct

Right on track! Feature selection deals with removing nuisance variables.

### What is the definition of backward elimination?
1 / 1 point

* In this method we start by selecting all the features. We then remove the least significant feature based on model performance. We repeat this step until no improvement is observed in model performance.

Correct

That’s right! Great job!

### Embedded methods combine the best of both worlds, filter and wrapper methods. Embedded methods are: (Check all that apply)
1 / 1 point

* More efficient than filter methods
Correct

Nice going! Filter methods suffer from inefficiencies as they need to look at all the possible feature subsets.

* Faster than wrapper methods
Correct

Correct! Wrapper methods are based  on the greedy algorithm and thus solutions are slow to compute.
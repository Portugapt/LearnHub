# Hyperparameter tuning

- [Hyperparameter tuning](#hyperparameter-tuning)
  - [NAS](#nas)
  - [Keras autotuner](#keras-autotuner)
  - [Neural Architecture Search](#neural-architecture-search)
    - [Micro and Macro Search Space](#micro-and-macro-search-space)
  - [Search Strategies](#search-strategies)
  - [Save costs in search](#save-costs-in-search)
  - [Cloud MLs](#cloud-mls)
  - [Cloud Lab](#cloud-lab)
  - [References](#references)
  - [Quiz 1 - Hyperparameter Tuning and Neural Architecture Search](#quiz-1---hyperparameter-tuning-and-neural-architecture-search)
    - [Neural Architecture Search (NAS) was a promising technique that failed to surpass hand-designed architectures in terms of test set accuracy.](#neural-architecture-search-nas-was-a-promising-technique-that-failed-to-surpass-hand-designed-architectures-in-terms-of-test-set-accuracy)
    - [Which of the following characteristics best describe hyperparameters? (Select all that apply)](#which-of-the-following-characteristics-best-describe-hyperparameters-select-all-that-apply)
    - [Does KerasTuner support multiple strategies?](#does-kerastuner-support-multiple-strategies)
  - [Quiz 2 - AutoML](#quiz-2---automl)
    - [Can Neural Architecture Search (NAS) be seen as a subfield of AutoML?](#can-neural-architecture-search-nas-be-seen-as-a-subfield-of-automl)
    - [Which of the following are dimensions of the Neural Architecture Search (NAS) technique? (Select all that apply)](#which-of-the-following-are-dimensions-of-the-neural-architecture-search-nas-technique-select-all-that-apply)
    - [What does the search space allow in Neural Architecture Search (NAS)? (Select all that apply)](#what-does-the-search-space-allow-in-neural-architecture-search-nas-select-all-that-apply)
    - [In the chain-structured Neural Network Architecture (NNA), space is parametrized by (Select all that apply):](#in-the-chain-structured-neural-network-architecture-nna-space-is-parametrized-by-select-all-that-apply)
    - [What are the main features of Automated Machine Learning (AutoML)? (Select all that apply)](#what-are-the-main-features-of-automated-machine-learning-automl-select-all-that-apply)
    - [What are the two main types of search spaces?](#what-are-the-two-main-types-of-search-spaces)
    - [In measuring AutoML efficacy, several strategies have been proposed to reduce performance cost estimation, including (Select all that apply):](#in-measuring-automl-efficacy-several-strategies-have-been-proposed-to-reduce-performance-cost-estimation-including-select-all-that-apply)
    - [The lower fidelity estimates are a performance estimation strategy that allows (Select all that apply):](#the-lower-fidelity-estimates-are-a-performance-estimation-strategy-that-allows-select-all-that-apply)
    - [Can network morphism modify an architecture while leaving the network's function unchanged?](#can-network-morphism-modify-an-architecture-while-leaving-the-networks-function-unchanged)

## NAS
Keras tuner, AutoML

NAS

![NAS1](https://i.imgur.com/7UAo9s4.png)

![NAS3](https://i.imgur.com/ZyYw9xA.png)

![NAS2](https://i.imgur.com/Z2LXHc7.png)

Hyperparameter tuning is not scalable in production.

## Keras autotuner

![KA1](https://i.imgur.com/Y89dHou.png)

![KA2](https://i.imgur.com/87kRPs8.png)

![KA3](https://i.imgur.com/wWB65co.png)

![KA4](https://i.imgur.com/mhZq5hs.png)

-----

![KA5](https://i.imgur.com/Cx1bg7O.png)

![KA6](https://i.imgur.com/ei2EtX0.png)

![KA7](https://i.imgur.com/TfFViPs.png)

![KA8](https://i.imgur.com/qG03t9P.png)

![KA9](https://i.imgur.com/9F5s44F.png)

![KA10](https://i.imgur.com/aq9Rh7v.png)

Go back to model and change manually the architecture.

## Neural Architecture Search

![NAS1](https://i.imgur.com/u65DwU0.png)

To reduce the size of the search problem, we need to limit the search space to the architectures which are best suited to the problem that we're trying to model. This helps reduce the search space, but it also means that a human bias will be introduced, which might prevent Neural Architecture Search from finding architectural blocks that go beyond current human knowledge. The search strategy defines how we explore the search space. We want to explore the search based quickly, but this might lead to premature convergence to a sub optimal region in the search space. The objective of Neural Architecture Search is to find architecture is that perform well on our data. The performance estimation strategy helps in measuring and comparing the performance of various architectures. A search strategies selects an architecture from a predefined search space of architectures. The selected architecture is passed to a performance estimation strategy, which returns it's estimated performance to the search strategy. The search space, search strategy and performance estimation strategy are the key components of Neural Architecture Search

![NAS2](https://i.imgur.com/BGCao9s.png)

![NAS3](https://i.imgur.com/HDK5Qp3.png)

### Micro and Macro Search Space

![micro](https://i.imgur.com/u9uvwof.png)

![macro](https://i.imgur.com/YnJCMsn.png)

## Search Strategies

![ss1](https://i.imgur.com/zEpAvJ9.png)

![ss2](https://i.imgur.com/kGdhCAD.png)

![ss3](https://i.imgur.com/1rcCZXG.png)

![ss4](https://i.imgur.com/pikV9G1.png)

![rl1](https://i.imgur.com/O6WGVbs.png)

## Save costs in search

![sc1](https://i.imgur.com/hVHgZRG.png)

![sc2](https://i.imgur.com/NPhH6ox.png)

![sc3](https://i.imgur.com/HVDgk0i.png)

## Cloud MLs

![sage](https://i.imgur.com/C2JJPSN.png)

![azure](https://i.imgur.com/1grPagh.png)

And GCP CloudML

![SAUCE](https://i.imgur.com/Ymrnli4.png)

## Cloud Lab

https://googlecoursera.qwiklabs.com/focuses/19762343?parent=lti_session


## References

https://arxiv.org/pdf/1611.01578.pdf

## Quiz 1 - Hyperparameter Tuning and Neural Architecture Search

### Neural Architecture Search (NAS) was a promising technique that failed to surpass hand-designed architectures in terms of test set accuracy.
1 / 1 point

* False
Correct

!!! note Spot on! In fact, NAS can design a novel network architecture that rivals the best human-invented architecture. 

### Which of the following characteristics best describe hyperparameters? (Select all that apply)
1 / 1 point

* Hyperparameters are set before launching the learning process.
Correct

!!! note Excellent! They need to be set before model training begins.

----

* Hyperparameters can be quite numerous even in small models.
Correct

!!! note Great job! Hyperparameters can be numerous, so, performing manual hyperparameter tuning can be a real brain teaser.

----

* Hyperparameters are not optimized in each training step.
Correct

!!! note You’re right on track! Hyperparameters are not automatically optimized during the training process.

----

### Does KerasTuner support multiple strategies?
1 / 1 point

* Yes
Correct

!!! note Exactly! KerasTuner comes with Bayesian Optimization, Hyperband, and Random Search algorithms built-in.


## Quiz 2 - AutoML

### Can Neural Architecture Search (NAS) be seen as a subfield of AutoML?
1 / 1 point

* Yes
Correct

!!! note Exactly! NAS can be seen as a subfield of AutoML and has significant overlap with hyperparameter optimization and meta-learning.

### Which of the following are dimensions of the Neural Architecture Search (NAS) technique? (Select all that apply)
1 / 1 point

* Performance Estimation Strategy
Correct

!!! note You got it! The objective of NAS is typically to find an architecture with the highest predictive performance.

* Search Space
Correct

!!! note Right! The search space defines the range of architectures that can be represented.

Training and Validation of the Architecture

* Search Strategy
Correct

!!! note Keep it up! The search strategy details how to explore the search space.

### What does the search space allow in Neural Architecture Search (NAS)? (Select all that apply)
1 / 1 point

* Restricting unbounded search spaces to have a maximum depth.
Correct

!!! note Great job! It gives rise to search spaces with (potentially many) conditional dimensions.


* Defining which neural architectures we might discover in principle.
Correct

!!! note You're right on track!. The search space defines which architectures can be represented.

* Reducing the size of the search space incorporating prior knowledge about well-suited properties.
Correct

!!! note That's right! This task can simplify the search space.

### In the chain-structured Neural Network Architecture (NNA), space is parametrized by (Select all that apply):
1 / 1 point

* Hyperparameters associated with the operation.
Correct

!!! note Well done! Search space is related to the number of units for fully connected networks.

* A number of n sequentially fully-connected layers.
Correct

!!! note Spot on! A chain-structured NNA can be written as a sequence of n layers.

* The operation every layer can execute.
Correct

!!! note Excellent!. Among the most common operations are pooling, convolution, and more advanced layers.

### What are the main features of Automated Machine Learning (AutoML)? (Select all that apply)
1 / 1 point

* AutoML aims to automate the decision-making in a data-driven and objective way.
Correct

!!! note Correct! AutoML determines the approach that works best for a certain application.

* AutoML technologies democratize AI with customized state-of-the-art machine learning.
Correct

!!! note That’s true! AutoML seeks to make state-of-the-art machine learning approaches accessible to data scientists with limited machine learning expertise.

* AutoML aims to automate the end-to-end process of machine learning to produce simpler and faster solutions.
Correct

!!! note Indeed! AutoML enables developers -even those with minimal experience in machine learning- to readily produce simple, optimal solutions.

### What are the two main types of search spaces?
1 / 1 point

* Macro and Micro
Correct

!!! note Good job! Although their names are kind of backwards, that's what they're called.

### In measuring AutoML efficacy, several strategies have been proposed to reduce performance cost estimation, including (Select all that apply):
1 / 1 point

* Lower fidelity estimates
Correct

!!! note Yes! Lower fidelity estimates try to reduce the training time by reframing the problem.

* Weight Inheritance/ Network Morphisms
Correct

!!! note Nailed it! Using network morphism, the weights of novel architectures are initialized based on the weights in previously trained architectures.

* Learning Curve Extrapolation
Correct

!!! note Nicely done! Extrapolation is a sensitive and valid choice based on the assumption that the learning curve can be reliably predicted.

### The lower fidelity estimates are a performance estimation strategy that allows (Select all that apply):
1 / 1 point

* Training with less filters per layer
Correct

!!! note Way to go! The lower fidelity estimates strategy uses fewer filters per layer and fewer cells.

* Training on lower-resolution
Correct

!!! note That's it! The lower fidelity reduces the computational cost as a result.

* Training on a subset of the data
Correct

!!! note Correct! It also reduces training times.

### Can network morphism modify an architecture while leaving the network's function unchanged?
1 / 1 point

* Yes
Correct

!!! note Exactly! This property increases the network’s capacity retaining a high performance as a result.
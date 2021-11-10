- [Questions](#questions)
- [Key challenges in creating an ML production ready model](#key-challenges-in-creating-an-ml-production-ready-model)
  - [Keywords](#keywords)
  - [Key Challenges](#key-challenges)
    - [Milestones](#milestones)
- [Why low average error isn't good enough](#why-low-average-error-isnt-good-enough)
- [Establish a baseline](#establish-a-baseline)
- [Tips for getting started](#tips-for-getting-started)
- [Quiz - Selecting and Training a Model](#quiz---selecting-and-training-a-model)
  - [1. Which of these is a more accurate description of a data-centric approach to ML development?](#1-which-of-these-is-a-more-accurate-description-of-a-data-centric-approach-to-ml-development)
  - [2. Say you have an algorithm that diagnoses illnesses from medical X-rays, and achieves high average test set accuracy. What can you now say with high confidence about this algorithm? Check all that apply.](#2-say-you-have-an-algorithm-that-diagnoses-illnesses-from-medical-x-rays-and-achieves-high-average-test-set-accuracy-what-can-you-now-say-with-high-confidence-about-this-algorithm-check-all-that-apply)
  - [3. Which of these statements about establishing a baseline are accurate? Check all that apply.](#3-which-of-these-statements-about-establishing-a-baseline-are-accurate-check-all-that-apply)
  - [4. On a speech recognition problem, say you run the sanity-check test of trying to overfit a single training example. You pick a clearly articulated clip of someone saying “Today’s weather”, and the algorithm fails to fit even this single audio clip, and outputs “______”. What should you do?](#4-on-a-speech-recognition-problem-say-you-run-the-sanity-check-test-of-trying-to-overfit-a-single-training-example-you-pick-a-clearly-articulated-clip-of-someone-saying-todays-weather-and-the-algorithm-fails-to-fit-even-this-single-audio-clip-and-outputs-______-what-should-you-do)
- [Error analysis example](#error-analysis-example)
- [Prioritizing what to work on](#prioritizing-what-to-work-on)
- [Skewed datasets](#skewed-datasets)
- [Performance auditing](#performance-auditing)
- [Data-centric AI development](#data-centric-ai-development)
- [Data augmentation](#data-augmentation)
- [Can adding data hurt?](#can-adding-data-hurt)
- [Adding new features](#adding-new-features)
- [Experiment tracking](#experiment-tracking)
- [Big Data vs Good Data](#big-data-vs-good-data)
- [Quiz - Modeling challenges](#quiz---modeling-challenges)
  - [1. You are working on a binary classification ML algorithm that detects whether a patient has a specific disease. In your dataset, 98% of the training examples (patients) don’t have the disease, so the dataset is very skewed. Accuracy on both positive and negative classes is important. You read a research paper claiming to have developed a system that achieves 95% on ____ metric. What metric would give you the most confidence they’ve built a useful and non-trivial system? (Select one)](#1-you-are-working-on-a-binary-classification-ml-algorithm-that-detects-whether-a-patient-has-a-specific-disease-in-your-dataset-98-of-the-training-examples-patients-dont-have-the-disease-so-the-dataset-is-very-skewed-accuracy-on-both-positive-and-negative-classes-is-important-you-read-a-research-paper-claiming-to-have-developed-a-system-that-achieves-95-on-____-metric-what-metric-would-give-you-the-most-confidence-theyve-built-a-useful-and-non-trivial-system-select-one)
  - [2. On the previous problem above with 98% negative examples, if your algorithm is print(“1”) (i.e., it says everyone has the disease). Which of these statements is true?](#2-on-the-previous-problem-above-with-98-negative-examples-if-your-algorithm-is-print1-ie-it-says-everyone-has-the-disease-which-of-these-statements-is-true)
  - [3. True or False? During error analysis, each example should only be assigned one tag. For example, in a speech recognition application you may have the tags: “car noise”, “people noise” and “low bandwidth”. If you encounter an example with both car noise and low bandwidth audio, you should use your judgement to assign just one of these two tags rather than apply both tags.](#3-true-or-false-during-error-analysis-each-example-should-only-be-assigned-one-tag-for-example-in-a-speech-recognition-application-you-may-have-the-tags-car-noise-people-noise-and-low-bandwidth-if-you-encounter-an-example-with-both-car-noise-and-low-bandwidth-audio-you-should-use-your-judgement-to-assign-just-one-of-these-two-tags-rather-than-apply-both-tags)
  - [4. You are building a visual inspection system. Error analysis finds:](#4-you-are-building-a-visual-inspection-system-error-analysis-finds)
  - [5. You’re considering applying data augmentation to a phone visual inspection problem. Which of the following statements are true about data augmentation? (Select all that apply)](#5-youre-considering-applying-data-augmentation-to-a-phone-visual-inspection-problem-which-of-the-following-statements-are-true-about-data-augmentation-select-all-that-apply)

# Questions


# Key challenges in creating an ML production ready model

## Keywords

- Model-centric AI development
- Data-centric AI development

## Key Challenges

Each time in the loop, know what to change.  
Either the Model, or the hyperparameters, or the data.  

![Cycle](https://i.imgur.com/sYnNIuG.png)

### Milestones

1. Do well on the training set
2. Do well on the dev/test sets
3. Do well in **business metrics/project goals**

We need something above a low average error on the test set. It isn't enough for a business. 

![Challenges](https://i.imgur.com/c59WYuf.png)

# Why low average error isn't good enough

![disproportion](https://i.imgur.com/JEmzcXM.png)

Some slices of the data are disproportionally more important, and in this case, Navigational queries users are more unforgiving if these queries don't yield out the results at the top.

![fairness](https://i.imgur.com/0gro2ip.png)

The same thing happens with slices of data might give imoral and unfair bias.

![rareclasses](https://i.imgur.com/0qXO6Oh.png)

And finally, rare classes (undersampled data), the test set might have an astronomical accuracy.



# Establish a baseline

HLP - Human level performance

Create a baseline metric for human and machine levels of performance.
![Baselines ](https://i.imgur.com/VgwZbBZ.png)

![Data Baslines](https://i.imgur.com/bFNZQgG.png)


![Types of baselines](https://i.imgur.com/j4WE6su.png)


Always give a rough baseline. Don't accept the business expectation on high levels of accuracy/performance when you still don't have the notion of the baseline.


# Tips for getting started

![Starting](https://i.imgur.com/BPgCsLX.png)

I should take into consideration the software and hardware constrains.

![Constrains](https://i.imgur.com/LtpgIE5.png)


Always try to overfit the model in a small/1sample set.
It's easier to find out if the algorithms works and to catch/fix bugs.
![Sanity Check](https://i.imgur.com/AD1BQHi.png)

# Quiz - Selecting and Training a Model

## 1. Which of these is a more accurate description of a data-centric approach to ML development?

- [X] Holding the neural network architecture fixed, work to improve the data to do well on the problem.

- [ ] Holding the training data fixed, work to improve your neural network’s architecture to do well on the problem.

## 2. Say you have an algorithm that diagnoses illnesses from medical X-rays, and achieves high average test set accuracy. What can you now say with high confidence about this algorithm? Check all that apply. 

- [ ] It does well even on rare classes of diseases. 

- [ ] Its diagnoses are roughly equally accurate on all genders and ethnicities, so we are confident it is not biased against any gender or ethnicity.

- [ ] The system can be safely deployed in a healthcare setting. 

- [X] None of the above.  

## 3. Which of these statements about establishing a baseline are accurate? Check all that apply.

- [ ] Open-source software should not be used to establish a baseline, since the performance of a good open source implementation might be too good and thus too hard to beat. 

- [X] Human level performance (HLP) is generally more effective for establishing a baseline on unstructured data problems (such as images and audio) than structured data problems

- [X] It can be established based on an older ML system

- [X] For unstructured data problems, using human-level performance as the baseline can give an estimate of the irreducible error/Bayes error and what performance is reasonable to achieve.
## 4. On a speech recognition problem, say you run the sanity-check test of trying to overfit a single training example. You pick a clearly articulated clip of someone saying “Today’s weather”, and the algorithm fails to fit even this single audio clip, and outputs “______”. What should you do?

- [X] Debug the code/algorithm/hyperparameters to make it pass this sanity-check test first, before moving to larger datasets.

- [ ] Use data augmentation on this one audio clip to make sure the algorithm hears a variety of examples of “today’s weather” to fit this phrase better. 

- [ ] Create a training set of this example repeated 100 times to force the algorithm to learn to fit this example well.

- [ ] Train the algorithm on a larger dataset to help it to fit the data better.


# Error analysis example

Manual process to tag the misclassified, and their issues.

![](https://i.imgur.com/gyZWqFl.png)

Error analysis is an iterative process.
Here's an example of iterative tags we can propose.

![Iterative process](https://i.imgur.com/RbaXJ62.png)

So far we've only talked about tagging the mislabeled examples for time efficiency.
You might focus your attention on tagging the mislabeled,
the misclassified examples.
But if this tag you can apply to both correctly labeled and
two mislabeled examples, then you can ask of all the data of that tag,
what fraction is misclassified?

![Useful metrics](https://i.imgur.com/SIXImNa.png)

# Prioritizing what to work on

It might be better to work on
Clean speech or People noise
![Prio](https://i.imgur.com/GAgqjjg.png)

![Prio questions](https://i.imgur.com/ycGGEJ7.png)


Using these methods we know in which type of data to focus on getting more.
![](https://i.imgur.com/0gbzZ1J.png)

# Skewed datasets

Accuracy is not good in skewed datasets.
Accuracy overall, is not a good metric.
![Rare cases](https://i.imgur.com/oUwSolE.png)

![F1](https://i.imgur.com/g5adbg2.png)

![Confusion Matrix](https://i.imgur.com/rQptn6W.png)

![Multi-class](https://i.imgur.com/WstDSyx.png)

# Performance auditing

![cycle](https://i.imgur.com/NnKDFBm.png)

Brainstorm the different ways the system might go wrong.

![Audit things](https://i.imgur.com/URUdBrh.png)

# Data-centric AI development

![](https://i.imgur.com/omwisU5.png)

The quality of the data is paramount.

# Data augmentation
This section is really interesting


![](https://i.imgur.com/zFuGpiZ.png)

There's a gap for improvement.

> That's what you're doing if you collect or
somehow gets more data with cafe noise and add that your training set,
you're pulling up the performance of the algorithm on inputs with cafe noise.
And what that will tend to do,
is pull up this rubber sheet in the adjacent region as well.
So if performance on cafe noise goes up, probably performance
on the nearby points will go up too and performance on far away.
Points may or may not go up as much.
It turns out that for unstructured data problems,
pulling up one piece of this rubber sheet is unlikely to cause
a different piece of the rubber sheet to dip down really far below.
Instead, pulling up one point causes nearby points to be pulled up quite a lot
and far away points may be pulled up a little bit, or if you're lucky,
maybe more than a little bit.

![Checklist](https://i.imgur.com/hX1y5IL.png)

> Taking a data-centric approach AI development,
sometimes it's useful to instead use
a data iteration loop where you
repeatedly take the data and the model,
train your learning algorithm, do error analysis,
and as you go through this loop,
focus on how to add
data or improve the quality of the data. 

![data loop](https://i.imgur.com/JDHGu6p.png)

>For many practical applications,
taking this data iteration loop approach,
with a robust hyperparameter search, that's important too.
Taking of data iteration loop approach,
results in faster improvements
to your learning algorithm performance,
depending on your problem

# Can adding data hurt?

Adding to specific parts of the training set, the distribution to the test set becomes different.
This usually doesn't hurt the performance.

![](https://i.imgur.com/tzQpbqm.png)


![](https://i.imgur.com/fovVO69.png)

Some cases are truly ambiguous. 

# Adding new features

![](https://i.imgur.com/mfTUJoJ.png)

Learn FeatureTools.

![Data life](https://i.imgur.com/KD5Ydnf.png)

Data iteration process

# Experiment tracking

![](https://i.imgur.com/Bhwjkcf.png)

![](https://i2.wp.com/neptune.ai/wp-content/uploads/MLOps_cycle.jpg?resize=1024%2C576&ssl=1)
([Source](https://neptune.ai/blog/ml-experiment-tracking))

# Big Data vs Good Data

![](https://i.imgur.com/9noh074.png)

# Quiz - Modeling challenges

## 1. You are working on a binary classification ML algorithm that detects whether a patient has a specific disease. In your dataset, 98% of the training examples (patients) don’t have the disease, so the dataset is very skewed. Accuracy on both positive and negative classes is important. You read a research paper claiming to have developed a system that achieves 95% on ____ metric. What metric would give you the most confidence they’ve built a useful and non-trivial system? (Select one) 

- [ ] Accuracy

- [ ] Precision

- [X] F1 score

- [ ] Recall

## 2. On the previous problem above with 98% negative examples, if your algorithm is print(“1”) (i.e., it says everyone has the disease). Which of these statements is true?

- [ ] The algorithm achieves 0% precision.

- [ ] The algorithm achieves 0% recall.

- [X] The algorithm achieves 100% recall.

- [ ] The algorithm achieves 100% precision.

## 3. True or False? During error analysis, each example should only be assigned one tag. For example, in a speech recognition application you may have the tags: “car noise”, “people noise” and “low bandwidth”. If you encounter an example with both car noise and low bandwidth audio, you should use your judgement to assign just one of these two tags rather than apply both tags. 

- [X] False

- [ ] True

## 4. You are building a visual inspection system. Error analysis finds:

| Type of defect 	| Accuracy 	| HLP 	| % of data 	|
|:--------------:	|:--------:	|:---:	|:---------:	|
| Scratch        	| 95%      	| 98% 	| 50%       	|
| Discoloration  	| 90%      	| 90% 	| 50%       	|

- Based on this, what is the more promising type of defect to work on?

- [ ] Discoloration, because the algorithm’s accuracy is lower and thus there’s more room for improvement.

- [ ] Discoloration, because HLP is lower which suggests this is therefore the harder problem that thus needs more attention.

- [X] Scratch defects, because the gap to HLP is higher and thus there’s more room for improvement. 

- [ ] Work on both classes equally because they are each 50% of the data. 

## 5. You’re considering applying data augmentation to a phone visual inspection problem. Which of the following statements are true about data augmentation? (Select all that apply)

- [ ] Data augmentation should distort the input sufficiently to make sure they are hard to classify by humans as well. 

- [X] GANs can be used for data augmentation.

- [ ] Data augmentation should try to generate more examples in the parts of the input space where the algorithm is already doing well and there’s no need for improvement.

- [X] Data augmentation should try to generate more examples in the parts of the input space where you’d like to see improvement in the algorithm’s performance. 

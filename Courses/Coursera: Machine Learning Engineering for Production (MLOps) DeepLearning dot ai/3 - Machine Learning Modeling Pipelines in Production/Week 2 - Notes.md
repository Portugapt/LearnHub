# Dimensionality, Quantization and Pruning

- [Dimensionality, Quantization and Pruning](#dimensionality-quantization-and-pruning)
  - [Dimensionality](#dimensionality)
  - [Reduction techniques](#reduction-techniques)
  - [Quantization and Pruning, why and how](#quantization-and-pruning-why-and-how)
  - [Lab 1](#lab-1)
  - [Quiz 1 - Dimensionality Reduction](#quiz-1---dimensionality-reduction)
    - [Fill in the blanks with the correct answer according to the descriptions in the boxes below:](#fill-in-the-blanks-with-the-correct-answer-according-to-the-descriptions-in-the-boxes-below)
    - [What does the X value represent?](#what-does-the-x-value-represent)
    - [Which of the following are problems of high dimensionality in model performance? (Select all that apply)](#which-of-the-following-are-problems-of-high-dimensionality-in-model-performance-select-all-that-apply)
    - [What does the following line of code refer to?  count_params(model_n.trainable_variables)](#what-does-the-following-line-of-code-refer-to--count_paramsmodel_ntrainable_variables)
    - [The amount of training data available, the complexity of the decision surface, and the classifier type define the number of ____________ to be used](#the-amount-of-training-data-available-the-complexity-of-the-decision-surface-and-the-classifier-type-define-the-number-of-____________-to-be-used)
    - [True Or False: Classification subspaces allow to minimize separation among classes, while regression subspaces are used for maximizing correlation between projected data and response variable.](#true-or-false-classification-subspaces-allow-to-minimize-separation-among-classes-while-regression-subspaces-are-used-for-maximizing-correlation-between-projected-data-and-response-variable)
  - [Quiz 2 - Quantization and Pruning](#quiz-2---quantization-and-pruning)
    - [True Or False: Today, due to developments in machine learning research, and performance improvements for mobile and edge devices, there exists a wide range of options to deploy a machine learning solution locally.](#true-or-false-today-due-to-developments-in-machine-learning-research-and-performance-improvements-for-mobile-and-edge-devices-there-exists-a-wide-range-of-options-to-deploy-a-machine-learning-solution-locally)
    - [Which of the following benefits does machine learning provide to  mobile & IoT businesses that use it? (Select all that apply)](#which-of-the-following-benefits-does-machine-learning-provide-to--mobile--iot-businesses-that-use-it-select-all-that-apply)
    - [ML Kit brings Google's machine learning expertise to mobile developers. Which of the following are features of ML Kit? (Select all that apply)](#ml-kit-brings-googles-machine-learning-expertise-to-mobile-developers-which-of-the-following-are-features-of-ml-kit-select-all-that-apply)
    - [In per-tensor quantization, weights are represented by int8 two’s complement values in the range _____________ with zero-point _____________](#in-per-tensor-quantization-weights-are-represented-by-int8-twos-complement-values-in-the-range-_____________-with-zero-point-_____________)
    - [Quantization squeezes a small range of floating-point values into a fixed number. What are the impacts of quantization on the behavior of the model?](#quantization-squeezes-a-small-range-of-floating-point-values-into-a-fixed-number-what-are-the-impacts-of-quantization-on-the-behavior-of-the-model)
    - [True Or False: One family of optimizations, known as pruning, aims to remove neural network connections, increasing the number of parameters involved in the computation.](#true-or-false-one-family-of-optimizations-known-as-pruning-aims-to-remove-neural-network-connections-increasing-the-number-of-parameters-involved-in-the-computation)
    - [Which of the following describe the benefits of applying sparsity with a pruning routine? (Select all that apply)](#which-of-the-following-describe-the-benefits-of-applying-sparsity-with-a-pruning-routine-select-all-that-apply)

## Dimensionality

![dim1](https://i.imgur.com/l8jshlR.png)

Today, data science tends to be more about integrating everything end to end, generating and storing data is becoming faster, easier and less expensive. So there's a tendency for people to measure everything they can and include ever more complex feature transformations. As a result, datasets are often high dimensional, containing a large number of features, although the relevancy of each feature for analyzing this data is not always clear.

![dim2](https://i.imgur.com/OugKDUP.png)

![dim3](https://i.imgur.com/oU1VivE.png)

![dim4](https://i.imgur.com/U1hgScT.png)

![dim5](https://i.imgur.com/pSXtgnP.png)

![dim6](https://i.imgur.com/M3OeBQw.png)

![dim7](https://i.imgur.com/PylHkI3.png)

![dim8](https://i.imgur.com/JF4H4Y7.png)

![dim9](https://i.imgur.com/RneIG2D.png)

## Reduction techniques

![red1](https://i.imgur.com/y9DZI4K.png)

![red2](https://i.imgur.com/wkOnvdn.png)

![red3](https://i.imgur.com/wkOnvdn.png)

![red4](https://i.imgur.com/QEoThfP.png)

![red5](https://i.imgur.com/jpojDax.png)

![red6](https://i.imgur.com/IsrUkV7.png)

## Quantization and Pruning, why and how

![q1](https://i.imgur.com/YSzXYoT.png)

![q2](https://i.imgur.com/uMn5EH7.png)

![q3](https://i.imgur.com/x4TXUFM.png)

![q4](https://i.imgur.com/Seb27E3.png)

![q5](https://i.imgur.com/lbmLW8r.png)

Quantization, in essence, lessens or reduces the number of bits needed to represent information. However, you may notice that as you reduce the number of pixels beyond a certain point, depending on the image, it may get harder to recognize what that image is.

![q6](https://i.imgur.com/jVmXItn.png)

![q7](https://i.imgur.com/r1Dj6O0.png)

![q8](https://i.imgur.com/oc4NJk7.png)

![q9](https://i.imgur.com/bylRS2Z.png)

![q10](https://i.imgur.com/HkOgijt.png)

![q11](https://i.imgur.com/fHyAlbU.png)

![q12](https://i.imgur.com/FOJQ8RO.png)

![q13](https://i.imgur.com/NpAj95k.png)

![p1](https://i.imgur.com/CoRcLju.png)

![p2](https://i.imgur.com/Cg7hAsT.png)

## Lab 1 

Define input layers 


```python
    # input layer
    inputs = {
        colname: layers.Input(name=colname, shape=(), dtype='float32')
        for colname in NUMERIC_COLS
    }

    # feature_columns
    feature_columns = {
        colname: fc.numeric_column(colname)
        for colname in NUMERIC_COLS
    }
```

```python
tf.keras.utils.plot_model(model, 'dnn_model.png', show_shapes=False, rankdir='LR')
```


## Quiz 1 - Dimensionality Reduction

### Fill in the blanks with the correct answer according to the descriptions in the boxes below: 
![imgquiz1](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/d91K6wGjSNKdSusBowjSCQ_0ed03d38739e4fa4bd048e9bb9fbf5f1_Quizz_C3_W2.png?expiry=1642723200000&hmac=3CDzq3oeV0Vjkm_ZIZ0f3lPrqEGWAfmiyLLL-SUJtO8)
1 / 1 point

* Data mining. 2. Data Science.
Correct

!!! note That’s right! The “before” and “now” of performance and resource requirements are represented respectively by the Data Mining and Data Science concepts.

### What does the X value represent? 
![imgquiz2](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/qGuSVT_BTDerklU_wbw3Yw_3ecb1ec5e9af49fb810b8ba2dbe96df1_Quizz_C3_W2.png?expiry=1642723200000&hmac=lsDYVUDpQwBbTC2lwlvqGZvxqPXq5eVlUJ0t0_4HYlQ)
1 / 1 point

* The optimal number of features.
Correct

!!! note Exactly! The x-axis coordinate of this critical point represents the number of features required by the classifier to work at its best. 

### Which of the following are problems of high dimensionality in model performance? (Select all that apply)
1 / 1 point

* The possibility of more correlated features is greater.
Correct

!!! note You’ve got it! When having more dimensions, it is possible to have more correlated features making the selection of the most relevant features a more difficult task.

* Solutions take longer to reach global optimum
Correct

!!! note Right on track! Very often, reaching a global optimum is a more difficult task when dealing with high-dimensional problems.

* Higher runtimes and system requirements
Correct

!!! note Correct! The more dimensions, the higher the system requirements. Therefore, dimensionality reduction helps optimize the system's performance.

### What does the following line of code refer to?  count_params(model_n.trainable_variables)
1 / 1 point

* The number of training parameters for Model n.
Correct

!!! note That’s right! This code line allows to count the number of training parameters for the input model.

### The amount of training data available, the complexity of the decision surface, and the classifier type define the number of ____________ to be used
1 / 1 point

* Features
    Correct

!!! note That’s right! These three aspects define the amount of features that will be used in a machine learning problem. 

### True Or False: Classification subspaces allow to minimize separation among classes, while regression subspaces are used for maximizing correlation between projected data and response variable.
1 / 1 point

* False
Correct

!!! note That’s right! Classification subspaces maximize the separation among classes, while regression intends to maximize the correlation between two variables.

## Quiz 2 - Quantization and Pruning

### True Or False: Today, due to developments in machine learning research, and performance improvements for mobile and edge devices, there exists a wide range of options to deploy a machine learning solution locally.
1 / 1 point

* True
Correct

!!! note That’s right! With mobile devices becoming increasingly more powerful and at the same time cheaper, these devices are now able to deploy machine learning solutions at the edge.

### Which of the following benefits does machine learning provide to  mobile & IoT businesses that use it? (Select all that apply)
1 / 1 point

* Strengthening security.
Correct

!!! note That’s right! With ever increasing number of breaches and confidential data theft, companies want to strengthen their security. Employing ML in mobile and IoT security can help detect intrusions, protect your data, and respond to incidents automatically.

* Improving user experience with data.
Correct

!!! note That’s right! Businesses with a mobile or IoT strategy know how technology can capture and transform data to offer greater access to consumer information and therefore devise better means to enhance their user experiences.

* Automating operational efficiency.
Correct

!!! note That’s right! Mobile and IoT deployments can streamline your business and help you make accurate predictions. Also, the automation of some processes can decrease the time of information analysis, and therefore, can be crucial to improve operational efficiency.

### ML Kit brings Google's machine learning expertise to mobile developers. Which of the following are features of ML Kit? (Select all that apply)
1 / 1 point

* Access to cloud-based web services
Correct

!!! note That’s right! With ML, you can upload your models through the Firebase console and let the service take care of hosting and serving them to your app users.

* Model customization
Correct

!!! note That’s right! With ML, you can customize your device ML features, such as facial detection, bar-code scanning, and object detection, among others.

* Pre-trained model compatibility
Correct

!!! note That’s right! With ML, you can use a pre-trained TensorFlow Lite set of vetted models, provided they meet a set of criteria.

### In per-tensor quantization, weights are represented by int8 two’s complement values in the range _____________ with zero-point _____________
1 / 1 point

* [-127, 127], equal to 0
Correct

!!! note That's right! In per-tensor weights, there are two complement values ​​in the range [-127, 127], with zero-point equal to 0 in approximates.

### Quantization squeezes a small range of floating-point values into a fixed number. What are the impacts of quantization on the behavior of the model?
1 / 1 point

* Layer weights changes and network activations
Correct

!!! note One of the significant impacts is the change of static parameters such as layer weights, and others could be dynamic such as activations within networks.

* Decreased interpretability of the ML model
Correct

!!! note That's right! In the case of ML interpretability, there are some effects imposed on the ML model after quantization. This means it’s hard to evaluate whether transforming a layer was going in the right. Therefore, the interpretability of the model may decrease.

* Changes in transformations and operation
Correct

!!! note That's right! You could have transformations like adding, modifying, removing operations, coalescing different operations, and so on. In some cases, transformations may need extra data.

### True Or False: One family of optimizations, known as pruning, aims to remove neural network connections, increasing the number of parameters involved in the computation.
1 / 1 point

* False
Correct

!!! note That's right! The pruning optimization aims to eliminate neural network connections, but instead of increasing the number of parameters, you have to reduce them. With pruning, you can lower the overall parameter count in the network and reduce their storage and computational cost.

### Which of the following describe the benefits of applying sparsity with a pruning routine? (Select all that apply)
1 / 1 point

* Gain speedups in CPU and some ML accelerators
Correct

!!! note That's right! You can even gain speeds in the CPU and ML throttles that fully exploit integer precision efficiencies in some cases.

* Can be used in tandem with quantization to get additional benefits
Correct

!!! note That's right! In some experiments, weight pruning is compatible with quantification, resulting in compounding benefits. Therefore, it is possible to further compress the pruned model by applying post-training quantization.

* Better storage and/or transmission
Correct

!!! note That's right! An immediate benefit that you can get out of pruning is disk compression of sparse tensors. Thus, you can reduce the model's size for its storage and transmission by applying simple file compression to the pruned checkpoint.
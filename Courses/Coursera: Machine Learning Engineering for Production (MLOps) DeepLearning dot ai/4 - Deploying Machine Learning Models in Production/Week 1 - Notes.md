# Model Serving

- [Model Serving](#model-serving)
  - [What and why model serving?](#what-and-why-model-serving)
  - [Serving Infrastructure](#serving-infrastructure)
  - [Deployment options](#deployment-options)
  - [Improving Prediction Latency and Reducing Resource Costs](#improving-prediction-latency-and-reducing-resource-costs)
  - [TensorFlow Serving](#tensorflow-serving)
  - [Quiz 1 - Introduction to Model Serving](#quiz-1---introduction-to-model-serving)
    - [What are the three key components we should consider when serving an ML Model in a production environment? (Select all that apply)](#what-are-the-three-key-components-we-should-consider-when-serving-an-ml-model-in-a-production-environment-select-all-that-apply)
    - [What happens after a while in operation to an offline-trained model dealing with new real-live data?](#what-happens-after-a-while-in-operation-to-an-offline-trained-model-dealing-with-new-real-live-data)
    - [In applications that are not user-facing, is throughput more critical than latency for customer satisfaction?](#in-applications-that-are-not-user-facing-is-throughput-more-critical-than-latency-for-customer-satisfaction)
    - [Nowadays, developers aim to minimize latency and maximize throughput in customer-facing applications. However, in doing so, infrastructure scales and costs increase. So, what strategies can developers implement to balance cost and customer satisfaction? (Select all that apply)](#nowadays-developers-aim-to-minimize-latency-and-maximize-throughput-in-customer-facing-applications-however-in-doing-so-infrastructure-scales-and-costs-increase-so-what-strategies-can-developers-implement-to-balance-cost-and-customer-satisfaction-select-all-that-apply)
  - [Quiz 2 - Introduction to Model Serving Infrastructure](#quiz-2---introduction-to-model-serving-infrastructure)
    - [Why do models become more complex?](#why-do-models-become-more-complex)
    - [What is the difference between optimizing and satisficing metrics?](#what-is-the-difference-between-optimizing-and-satisficing-metrics)
    - [Which of the following are NoSQL solutions for implementing caching and feature lookup? (Select all that apply)](#which-of-the-following-are-nosql-solutions-for-implementing-caching-and-feature-lookup-select-all-that-apply)
    - [True Or False: The main advantage of deploying a model in a large data center accessed by a remote call is that you can disregard costs in favor of model complexity.](#true-or-false-the-main-advantage-of-deploying-a-model-in-a-large-data-center-accessed-by-a-remote-call-is-that-you-can-disregard-costs-in-favor-of-model-complexity)
    - [True Or False: As a rule, you should opt for on-device inference whenever possible.](#true-or-false-as-a-rule-you-should-opt-for-on-device-inference-whenever-possible)
  - [Quiz 3 - Tensorflow Serving](#quiz-3---tensorflow-serving)
    - [What is the most straightforward way of installing TensorFlow Serving?](#what-is-the-most-straightforward-way-of-installing-tensorflow-serving)
    - [What is the advantage of using the TensorFlow-model-server-universal binary to install TensorFlow Serving over the TensorFlow-model-server binary?](#what-is-the-advantage-of-using-the-tensorflow-model-server-universal-binary-to-install-tensorflow-serving-over-the-tensorflow-model-server-binary)

## What and why model serving?

![ms1](https://i.imgur.com/Ldu3JqP.png)

![ms2](https://i.imgur.com/7coZ5ik.png)

![ms3](https://i.imgur.com/CwtLs28.png)

![ms4](https://i.imgur.com/SoisoVd.png)

![ms5](https://i.imgur.com/Mgsav7v.png)

![ms6](https://i.imgur.com/gWyL3wO.png)

![ms7](https://i.imgur.com/89H0ZoQ.png)

![ms8](https://i.imgur.com/jtDfgSe.png)

## Serving Infrastructure

![si1](https://i.imgur.com/TadPA06.png)

There's a natural wanting for more complex models. This can be severe the serving latency, but hopefully also increase accuracy

![si2](https://i.imgur.com/9kJAB8B.png)

More complexity can also mean higher costs in training and serving, increased complexity in the recording of all models, which in turn has a higher maintenance.

![si3](https://i.imgur.com/ZX7IWEP.png)

![si4](https://i.imgur.com/R85GzvV.png)

Predictive effectiveness versus operational constrains the model might have to satisfy (gating metric). Model size for exemple, is very important for mobile and edge devices.

![si5](https://i.imgur.com/cUhSUhb.png)

![si6](https://i.imgur.com/ZzHY0h8.png)

![si7](https://i.imgur.com/ruF12Vy.png)

Another thing to consider is the data input request. Requesting data can lower the speed a model is able to serve a user. Aggregation is a way to combat this. But overall, this storage, pre-computing and caching of data has a cost. 

![si8](https://i.imgur.com/Nd9aard.png)

## Deployment options

![do1](https://i.imgur.com/xWwkBYo.png)

Either in a centralized place, or on mobile/edge devices, and can be served offline.

![do2](https://i.imgur.com/5MitE9o.png)

![do3](https://i.imgur.com/W9V64hq.png)

On mobile, using the model recurrently can have huge impact on the device's battery and temperature. It's also constrained by the device GPU. Models also can be large, but as discussed in Prune, Quantization and Knowledge distillation methods, size can be reduced to acceptable values, while sacrificing performance metrics.

![do4](https://i.imgur.com/kvLIwLp.png)

![do5](https://i.imgur.com/ScCuTFa.png)

## Improving Prediction Latency and Reducing Resource Costs

![LRR1](https://i.imgur.com/AQNBbnB.png)

Multi-threaded execution, however, also results and increased performance variability depending on what else is running concurrently, and this is particularly the case for mobile apps. For example, some isolated tests could show a 2x speedup versus a single-threaded version, but if another app is executing at the same time, it can actually result in worse performance than a single-threaded one

![LRR2](https://i.imgur.com/MfwNyNf.png)

![LRR3](https://i.imgur.com/nOoWjEQ.png)

![LRR4](https://i.imgur.com/3eCHgLZ.png)

![LRR5](https://i.imgur.com/VU1bTAy.png)

## TensorFlow Serving



## Quiz 1 - Introduction to Model Serving

### What are the three key components we should consider when serving an ML Model in a production environment? (Select all that apply)
1 / 1 point

* Input Data
Correct

!!! note You’ve got it!  The model executed on-device makes predictions based on the input data.

* An interpreter
Correct

!!! note Right on track! An Interpreter encapsulates a pre-trained model in which operations are executed for inference.

* A model
Correct

!!! note Correct! Providing the algorithm and training the ML model is the first step towards putting it into production.

### What happens after a while in operation to an offline-trained model dealing with new real-live data?
1 / 1 point

* The model becomes stale.
Correct

!!! note Good job!  The model performance deteriorates to the point of the model not being any longer fit for purpose. This phenomenon is called model decay and should be carefully monitored.

### In applications that are not user-facing, is throughput more critical than latency for customer satisfaction?
1 / 1 point

* Yes, in this case, we are concerned with maximizing throughput with the lowest CPU usage.
Correct

!!! note Correct! Latency is not a key concern for back-end services.

### Nowadays, developers aim to minimize latency and maximize throughput in customer-facing applications. However, in doing so, infrastructure scales and costs increase. So, what strategies can developers implement to balance cost and customer satisfaction? (Select all that apply)
1 / 1 point

* GPU sharing
Correct

!!! note Nailed it! This strategy reduces the cost of GPU-accelerated computing.

* Multi-model serving
Correct

!!! note Yes! This approach scales back infrastructure.

* Optimizing inference models
Correct

!!! note Right on track! Optimization modifies a model to handle a higher load, reducing costs as a result.

## Quiz 2 - Introduction to Model Serving Infrastructure

### Why do models become more complex?
1 / 1 point

* To increase accuracy.
Correct

!!! note Absolutely! We apply more complex model architectures that allow including more features to increase accuracy.

### What is the difference between optimizing and satisficing metrics?
1 / 1 point

* Optimizing metrics measure the model's predictive effectiveness while satisficing metrics specify operational constraints.

!!! note Nailed it! First, aim to improve the model's predictive power until the infrastructure reaches a specific latency threshold. Then,  assess the results to approve the model or continue working on it.

### Which of the following are NoSQL solutions for implementing caching and feature lookup? (Select all that apply)
1 / 1 point

* Amazon DynamoDB
Correct

!!! note Excellent! Amazon DynamoDB is a scalable low-read latency database with an in-memory cache.

* Google Cloud Memorystore
Correct

!!! note That's right! This database is a good choice for achieving sub-millisecond read latencies on a limited amount of quickly changing data retrieved by a few thousand clients.

* Google Cloud Firestore
Correct

!!! note Right on! A good choice for millisecond read latencies on slowly changing data where storage scales automatically.

### True Or False: The main advantage of deploying a model in a large data center accessed by a remote call is that you can disregard costs in favor of model complexity.
1 / 1 point

* False
Correct

!!! note Exactly! For example, Google constantly looks for ways to improve its resource utilization and reduce costs in its applications and data centers.

### True Or False: As a rule, you should opt for on-device inference whenever possible.
1 / 1 point

* True
Correct

!!! note Absolutely! Following this general rule enhances the user experience by reducing the app's response time. There are exceptions, though, such as medical diagnosis, in which the model must be as accurate as possible, and latency is not that important.

## Quiz 3 - Tensorflow Serving

### What is the most straightforward way of installing TensorFlow Serving?
1 / 1 point

* Using Docker Images
Correct

!!! note Good Job! This route is the most recommended unless there are specific needs not addressed by running in a container.

### What is the advantage of using the TensorFlow-model-server-universal binary to install TensorFlow Serving over the TensorFlow-model-server binary?
1 / 1 point

* The universal binary works on most of the machines.
Correct

!!! note Spot on! TensorFlow-model-server-universal should work on most if not all machines out there since it doesn't include any platform-specific instruction sets.
# Model Serving: Patterns and Infrastructure

* Serve models and deliver inference results by building scalable and reliable infrastructure.
* Contrast the use case for batch and realtime inference and how to optimize performance and hardware usage in each case
* Implement techniques to run inference on both edge devices and applications running in a web browser
* Outline and structure your data preprocessing pipeline to match your inference requirements
* Distinguish the performance and resource requirements for static and stream based batch inference

- [Model Serving: Patterns and Infrastructure](#model-serving-patterns-and-infrastructure)
  - [Model Serving Architecture](#model-serving-architecture)
    - [TF Serving](#tf-serving)
    - [NVIDIA Trition](#nvidia-trition)
    - [Torch Serve](#torch-serve)
    - [KFServing](#kfserving)
  - [Scaling Infrastructure](#scaling-infrastructure)
  - [Online Inference](#online-inference)
  - [Data Preprocessing](#data-preprocessing)
  - [Batch Inference Scenarios](#batch-inference-scenarios)
  - [Qwiklab](#qwiklab)
  - [Quiz 1 - Model serving architecture](#quiz-1---model-serving-architecture)
    - [What is the core idea of the TensorFlow Serving Architecture?](#what-is-the-core-idea-of-the-tensorflow-serving-architecture)
    - [True or False: Triton Inference Server simplifies deployment since it is compatible with trained AI models from any framework.](#true-or-false-triton-inference-server-simplifies-deployment-since-it-is-compatible-with-trained-ai-models-from-any-framework)
    - [In the TorchServe architecture, where does the actual inference take place?](#in-the-torchserve-architecture-where-does-the-actual-inference-take-place)
  - [Quiz 2 - Scaling Infrastructure](#quiz-2---scaling-infrastructure)
    - [Why is managing scale paramount when serving a sophisticated model? (Select all that apply)](#why-is-managing-scale-paramount-when-serving-a-sophisticated-model-select-all-that-apply)
    - [True or False: The elasticity of vertical scaling allows to upgrade the hardware resources without taking the app offline.](#true-or-false-the-elasticity-of-vertical-scaling-allows-to-upgrade-the-hardware-resources-without-taking-the-app-offline)
    - [How do containers become lighter and more flexible than virtual machines?](#how-do-containers-become-lighter-and-more-flexible-than-virtual-machines)
  - [Quiz 3 - Online Inference](#quiz-3---online-inference)
    - [What are the main features of prediction from online inference? (Select all that apply)](#what-are-the-main-features-of-prediction-from-online-inference-select-all-that-apply)
    - [In which area of online inference is a model artifact and model run created to reduce memory consumption and latency?](#in-which-area-of-online-inference-is-a-model-artifact-and-model-run-created-to-reduce-memory-consumption-and-latency)
    - [True or False: Fast data caching using NoSQL databases is a cheap way of optimizing inference.](#true-or-false-fast-data-caching-using-nosql-databases-is-a-cheap-way-of-optimizing-inference)
  - [Quiz 4 - Data Preprocessing](#quiz-4---data-preprocessing)
    - [True or False: Data values that differ significantly from other observations are dealt with at the end of the preprocessing process.](#true-or-false-data-values-that-differ-significantly-from-other-observations-are-dealt-with-at-the-end-of-the-preprocessing-process)
    - [In which step you transform a given set of input features to generate a new set of more powerful features for prediction?](#in-which-step-you-transform-a-given-set-of-input-features-to-generate-a-new-set-of-more-powerful-features-for-prediction)
    - [Which of the following are classic uses of Representation Transformations? (Select all that apply)](#which-of-the-following-are-classic-uses-of-representation-transformations-select-all-that-apply)
  - [Quiz 5 - Batch inference scenarios](#quiz-5---batch-inference-scenarios)
    - [Which of the following are advantages of batch inference?](#which-of-the-following-are-advantages-of-batch-inference)
    - [True or False: The most important metric to optimize while performing batch predictions is throughput.](#true-or-false-the-most-important-metric-to-optimize-while-performing-batch-predictions-is-throughput)
    - [How can you save inference costs when generating recommendations on e-commerce?](#how-can-you-save-inference-costs-when-generating-recommendations-on-e-commerce)
  - [Quiz 6 - Batch Processing with ETL](#quiz-6---batch-processing-with-etl)
    - [What is the purpose of ETL pipelines?](#what-is-the-purpose-of-etl-pipelines)
    - [True or False: In distributed processing, latency increases because data is split into chunks and parallely processed by multiple workers.](#true-or-false-in-distributed-processing-latency-increases-because-data-is-split-into-chunks-and-parallely-processed-by-multiple-workers)
    - [Which of the following engines perform ETL on data? (Select all that apply)](#which-of-the-following-engines-perform-etl-on-data-select-all-that-apply)



## Model Serving Architecture

![msa1](https://i.imgur.com/GLaqJz5.png)

On-prem: Requires installation, configuration, maintenance of hardware, etc etc. Requires extensive in-house experience.

![msa2](https://i.imgur.com/S9PTQTN.png)

![msa3](https://i.imgur.com/RZTZTs3.png)

SImply put, there's a model file which contains the model. The model Server uses that model to run inference. The model server exposes an API through REST/gRPC, has is given inputs. Those inputs are transformed inside the model server and then run on the model file. The model infers and returns the results to the model server and afterwards to the client. 

![msa4](https://i.imgur.com/yl6j7zl.png)

### TF Serving

![tfs1](https://i.imgur.com/TUF0uNF.png)

![tfs2](https://i.imgur.com/2buC6Lw.png)

let's look at an example of how this would work. So let's take this as an example, say a source represents a tensorflow graph with frequently updated model weights. The weights are stored in a file and disk. The source detects a new version of the model weights. It creates a loader that contains a pointer to the model data on disk. The source notifies the dynamic manager of the aspired version. The dynamic manager applies the version policy and decides to load the new version. The dynamic manager tells the loader that is enough memory. The loader instantiates the tensorflow graph as a servable with these new weights. A client requests a handle to the latest version of the model and the dynamic manager returns a handle to the new version of the servable. You can then run inference using that servable and this is what you w

### NVIDIA Trition

![NVT1](https://i.imgur.com/jC5zGfW.png)

![nvt2](https://i.imgur.com/1j5MbMU.png)

![NVT3](https://i.imgur.com/2FZIovP.png)

Triton Inference Server integrates with Kubernetes for orchestration, metrics, and auto scaling. Triton also integrates with Kubeflow and Kubeflow Pipelines for an end-to-end AI workflow. The Triton Inference Server exports Prometheus metrics for monitoring GPU utilization, latency, memory usage, and inference throughput. It supports the standard HTTP gRPC interface to connect with other applications like load balancers. It can easily scale to any number of servers to handle increasing inference loads for any model. The Triton Inference Server can serve tens or hundreds of models through the Model Control API. Models can be explicitly loaded and unloaded into and out of the Inference server based on changes made in the model control configuration to fit in a GPU or CPU memory. It can be used to serve models and CPU too. It supports heterogeneous cluster with both GPUs and CPUs and does help standardized inference across these platforms.

### Torch Serve

![TS1](https://i.imgur.com/eaSnFI1.png)

![ts2](https://i.imgur.com/fEjpyFh.png)

### KFServing

![KFS1](https://i.imgur.com/pkfPhkQ.png)

## Scaling Infrastructure

https://kubernetes.io/docs/tutorials/kubernetes-basics/

![scal1](https://i.imgur.com/hHnh5BN.png)

Hugh datasets and complex architectures require a parallel way of training the networks. Maybe even distribute the data.

![scal2](https://i.imgur.com/EPInkVM.png)

Complex models also might take longer time to infer inputs, and it can be overloaded with requests. 

![vertical](https://i.imgur.com/M5KKvae.png)

Vertical scaling

![horizontal](https://i.imgur.com/hs4Etvn.png)

Horizontal scaling

![whyscal3](https://i.imgur.com/PXQiHGh.png)

![scal4](https://i.imgur.com/yTVEEUP.png)

![scal5](https://i.imgur.com/lOCCUmv.png)

![scal6](https://i.imgur.com/rOsBMym.png)

![scal7](https://i.imgur.com/0Pq2iGZ.png)

![kube](https://i.imgur.com/vqZKGWy.png)

## Online Inference

![oi1](https://i.imgur.com/9wzICNf.png)

![oi2](https://i.imgur.com/LQTiCQL.png)

![oi3](https://i.imgur.com/Ey0hFvk.png)

1. Infrastructure: Infer the model and input/output.
2. Model Architecture: Model architecture inference speed vs accuracy. 99% accurate 10x slower than 98% accurate
3. Model Compilation: Underlying support hardware, post-train process to refine memory consumption and latency 

![oi4](https://i.imgur.com/k4dlNVY.png)

Some most requested date can be stored in faster access data stores. It's not feasible to store all data in such storage types, but it might be cost efficient in the end to store some of it.

![oi5](https://i.imgur.com/GeYdvEE.png)

## Data Preprocessing

![dp1](https://i.imgur.com/oQRE9Te.png)

## Batch Inference Scenarios

![BI1](https://i.imgur.com/qVJUgLM.png)

When it's not feasible to execute in real time, and it's better to do them in a batch.
Useful for example in campaigns for inactive users, which have a high capacity to churn. 
Executed normally on a scheduled interval (weekly, daily, nightly)

![BI2](https://i.imgur.com/p8RKeIS.png)

Since there's no constrain on inference time, the models can be more complex.

![bi3](https://i.imgur.com/ydns9Bj.png)

![bi4](https://i.imgur.com/fHBQzE6.png)

## Qwiklab

https://googlecoursera.qwiklabs.com/focuses/19795158?parent=lti_session


## Quiz 1 - Model serving architecture

### What is the core idea of the TensorFlow Serving Architecture?
1 / 1 point

* The servable
Correct

!!! note Well done! The servable is the central abstraction in TF-Serving. Clients use these underlying objects to perform computation.

### True or False: Triton Inference Server simplifies deployment since it is compatible with trained AI models from any framework.
1 / 1 point

* True
Correct

!!! note Yes! Triton Inference Server allows deployment of models from any framework, from local storage, Google Cloud Platform, or AWS S3.

### In the TorchServe architecture, where does the actual inference take place?
1 / 1 point

* Model Workers at the backend
Correct

!!! note That's right! Model Workers are running instances of the model responsible for performing the actual inference. Thus, multiple workers can run simultaneously on Torch Serve.

## Quiz 2 - Scaling Infrastructure

### Why is managing scale paramount when serving a sophisticated model? (Select all that apply)
1 / 1 point

* The number of parameters increases considerably in more extensive and more sophisticated networks.
Correct

!!! note Absolutely! The cost of training a network goes beyond the data—the more complex the network, the higher the number of parameters that need to be tuned and fine-tuned.

* The costs of training deep neural networks with billions of operations on massive datasets are high.
Correct

!!! note That's right! Scaling out the hardware for training distributes the training across the hardware, making it far more efficient as a result. For example, it could take days to complete training on a standard CPU or a single GPU.

* The high volumes of requests to the model for inference can overwhelm the server.
Correct

!!! note You've got it! When the model is deployed, too many inference requests can overwhelm the server, so the ability to scale the runtime inference and the training is vital.

### True or False: The elasticity of vertical scaling allows to upgrade the hardware resources without taking the app offline.
1 / 1 point

False
Correct

!!! note Indeed! When vertical scaling you must take the app offline as the upgrade involves or even replaces the entire hardware.

### How do containers become lighter and more flexible than virtual machines?
1 / 1 point

* By running the apps on a bin/library within an operating system that does not run on hardware.
Correct

!!! note Nailed it! In containers, app instances don't require separate operating systems. In addition, the abstraction of having them run within a container runtime gives you greater flexibility.

## Quiz 3 - Online Inference

Question 1

### What are the main features of prediction from online inference? (Select all that apply)
1 / 1 point

* They are generated in real-time upon request.
Correct

* They are based on a single data observation at runtime.
Correct

* They can be made at any time of the day on demand.
Correct

### In which area of online inference is a model artifact and model run created to reduce memory consumption and latency?
1 / 1 point

* Model Compilation
Correct

!!! noteThat's right! Model Compilation are running instances of the model responsible for performing the actual inference. Thus, multiple workers can run simultaneously on Torch Serve.

### True or False: Fast data caching using NoSQL databases is a cheap way of optimizing inference.
1 / 1 point

False
Correct

## Quiz 4 - Data Preprocessing

### True or False: Data values that differ significantly from other observations are dealt with at the end of the preprocessing process.
1 / 1 point

False
Correct

### In which step you transform a given set of input features to generate a new set of more powerful features for prediction?
1 / 1 point

* Feature Construction
Correct

### Which of the following are classic uses of Representation Transformations? (Select all that apply)
1 / 1 point

* Vectorization
Correct

* One-hot encoding
Correct

* Change data format for the model
Correct

## Quiz 5 - Batch inference scenarios

### Which of the following are advantages of batch inference?
1 / 1 point

* You can wait for data retrieval to make predictions since they are not made available in real time.
Correct

* You can use complex machine learning models to improve accuracy since there is no constraint on inference time.
Correct

* You don’t need caching strategies so costs decrease.
Correct

### True or False: The most important metric to optimize while performing batch predictions is throughput.
1 / 1 point

* True
Correct

### How can you save inference costs when generating recommendations on e-commerce?
1 / 1 point

* Generating them on a schedule.
Correct

## Quiz 6 - Batch Processing with ETL

### What is the purpose of ETL pipelines?
1 / 1 point

* To extract data from data sources, transforming, and loading it into an output destination.
Correct

### True or False: In distributed processing, latency increases because data is split into chunks and parallely processed by multiple workers.
1 / 1 point

* False
Correct

### Which of the following engines perform ETL on data? (Select all that apply)
1 / 1 point

* Apache spark
Correct

* Google Cloud DataFlow
Correct
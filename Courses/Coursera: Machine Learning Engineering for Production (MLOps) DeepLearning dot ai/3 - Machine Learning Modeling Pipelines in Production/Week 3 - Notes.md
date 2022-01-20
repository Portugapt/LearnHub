# High-Performance Modeling & Knowledge Distilation

- [High-Performance Modeling & Knowledge Distilation](#high-performance-modeling--knowledge-distilation)
  - [Distributed Training](#distributed-training)
    - [One Device Stategy](#one-device-stategy)
    - [Mirrored Stategy](#mirrored-stategy)
    - [Parameter Server Strategy](#parameter-server-strategy)
  - [High-Performance Ingestion](#high-performance-ingestion)


## Distributed Training

![dt1](https://i.imgur.com/P55fyyy.png)

![dt2](https://i.imgur.com/ugIR97M.png)

![dt3](https://i.imgur.com/GPZbm1a.png)

![dt4](https://i.imgur.com/rxXbV5F.png)

![dt5](https://i.imgur.com/FGNKwIm.png)

![dt6](https://i.imgur.com/2uzoAMO.png)

![dt7](https://i.imgur.com/ufT6QT3.png)

### One Device Stategy

![ods](https://i.imgur.com/AlBEcBg.png)

### Mirrored Stategy

![MS1](https://i.imgur.com/5Vljn5l.png)

### Parameter Server Strategy

![pss1](https://i.imgur.com/weRU4Ok.png)

## High-Performance Ingestion

Accelerators are a key part of high-performance modeling, training, and inference, but accelerators are also expensive, so it's important to use them efficiently. That means keeping them busy, which requires you to supply them with enough data fast enough. That's why high-performance ingestion is important in high-performance modeling. Let's discuss that now. Let's discuss why input pipelines are often needed for training models and the issues around applying transformations on data. Generally, transformations deal with pre-processing tasks that tend to add overhead to your training input pipeline. For example, when augmenting huge image classification datasets, many of these transformations are often applied element wise. As a result, if it takes too long to apply transformations, this can lead to the CPU being underutilized while it waits for data and it's not just limited to the transformations. At times, you could have data that simply cannot fit into memory and it often becomes a challenge to build a scalable input data pipeline that will feed your data fast enough to keep your training processors busy. In the end, the goal should be to efficiently utilize the hardware available and reduce the time required to load the data from the disk, and also reduce the time required for pre-processing it. Input pipelines are important part of many training pipelines, but there are often similar requirements for inference pipelines as well. In the larger context of a training pipeline such as a TFX training pipeline, a high-performance input pipeline would be part of the trainer component and possibly other components like Transform that may need to do quite a bit of work on the data. There are many ways to design an efficient input pipeline. One framework that can help is TensorFlow data or tf.data. Let's consider TF data as an example of how to design an efficient input pipeline. You can view input pipelines as an ETL process, providing a framework to facilitate applying performance optimization. The 1st step involves extracting data from data stores that may be either local or remote, like hard drives, SSDs, cloud storage, and HDFS. In the 2nd step, data often needs to be pre-processed. This includes shuffling, batching, and repeating data. The way you order these transformations may have an impact on your pipelines performance. This is something that you need to be aware of when using any data transformation like map or batch or shuffle or repeat, and so forth. You then load the pre-processed data into the model, which may be training on a GPU or TPU and start training. A key requirement for high-performance input Pipelines is to parallel processing of data across the various systems to try to make maximum efficient use of the available compute, IO, and network resources. Especially for more expensive components such as accelerators, you want to keep them busy as much as possible. Let's look at a typical pattern that is easy to fall into and one that you really want to avoid. In this scenario, key hardware components, including CPUs and accelerators sit idle, waiting for the previous steps to complete. If you think about it, ETL, extract, transform, and load is a good mental model for data performance. Now, to give you some intuition on how pipelining can be carried out, each of the different phases of ETL use different hardware components in your system. Your extract phase is exercising your disk, your network for your loading from a remote system. Transform typically happens on the CPU and can be very CPU hungry. The load phase is exercising the DMA, or direct memory access subsystem and the connections to your accelerator, probably a GPU or TPU. Now, this is a much more efficient pattern than the previous one, although it's still not quite optimal. In practice, this pattern may be difficult to optimize further in many cases. As this diagram shows by parallelizing operations, you can overlap the different parts of ETL using a technique known as software pipelining. With software pipelining, you're extracting data for step 5, while you're transforming for step 4, and while you're loading data for step 3, and finally, your training for step 2 all at the same time. This results in a very efficient use of your compute resources. As a result, your training is much faster and your resource utilization is much higher. Notice that now there are only a few instances where your hard drive and CPU are actually sitting idle. Through pipelining your training procedure, you can overcome CPU bottlenecks by overlapping the CPU pre-processing and model execution of accelerators. While the accelerator is busy with training the model in the background, the CPU starts preparing data for the next training step. You can see there's a significant improvement in model training time when using pipelining. While you can still expect some idle time, it's greatly reduced by using pipelining. How do you optimize your data pipeline in practice? There are a few basic approaches that could potentially be used to accelerate your pipeline. Prefetching, for example, where you begin loading data for the next step before the current step completes. Other techniques involve parallelizing data extraction and transformation. Caching the dataset to get started with training immediately once a new epic begins, is also very effective when you have enough cash. Finally, you need to be aware of how you order these optimizations in your pipeline, to maximize the pipelines efficiency. With prefetching, you overlap the work of a producer with a work of a consumer, while the model is executing step as, the input pipeline is reading the data for step S plus 1. This reduces the total time it takes for a step to either train the model or extract data from disk, whichever is highest. The tf.data, API, provides the tf dataset prefetch transformation. You can use this to decouple the time when data is produced, from the time when the data is consumed. This transformation uses a background thread and an internal buffer to prefetch elements from the input dataset ahead of time before they are requested. Ideally, the number of elements to prefetch should be equal to, or possibly greater than, the number of batches consumed by a single training step. You can either manually tune this value, or set it to tf data experimental autotune, as in this example, which will configure the tf data runtime, to optimize the value dynamically at runtime. In a real-world setting, the input data may be stored remotely, for example, on GCS or HDFS. A dataset pipeline that works well when reading data locally, might become bottlenecked on Io when reading data remotely, because of the following differences between local and remote storage. Time=to-first-byte. Reading the first byte of a file from remote storage, can take orders of magnitude longer, than from local storage. Read throughput. Again, while remote storage typically offers large aggregate bandwidth, reading a single file might only be able to utilize a small fraction of this bandwidth. To reduce data extraction overhead, the tf data dataset interleave transformation is used to parallelize the data loading step, including interleaving contents of other datasets. The number of datasets to overlap as specified by the cycle length argument, while the level of parallelism is set with the num parallel calls argument. Similar to the prefetch transformation, the interleaved transformation supports tf data experimental auto-tune, which will delegate the decision about what level of parallelism to use for the tf data runtime. When preparing data, input elements may need to be preprocessed. For example, the tf data, API, offers the tf data dataset map transformation, which implies a user-defined function to each element of the input dataset. Element-wise preprocessing can be parallelized across multiple CPU cores. Similar to the prefetch and interleaved transformation, the map transformation provides the num parallel calls argument to specify the level of parallelism. Choosing the best value for the num parallel calls argument depends on your hardware, the characteristics of your training data such as size and shape, the cost of your map function, and what other processing is happening on the CPU at the same time. A simple heuristic is to use the number of available CPU cores. However, as with prefetch interleave transformations, the map transformation in tf data supports the tf data experimental autotune parameter, which will delegate the decision about which level of parallelism to use for the tf data runtime. Let's see what happens when you apply pre-processing in parallel on multiple samples. Here, the preprocessing steps overlap, reducing the overall time for a single iteration, this can potentially be a big win. Here, you implement the same preprocessing function, but apply it in parallel, on multiple samples. Tf data dataset includes the ability to cash a dataset, either in memory or on local storage. In many instances, caching is advantageous and leads to increased performance. This will save some operations, like file opening and data reading, from being executed during each epic. When you cache a dataset, the transformations before caching, like file opening and data reading, are executed only during the first epic, the next epics, we'll re-use the cache data. Let's consider two scenarios for caching. If the user-defined function passed into the map transformation is expensive, then it makes sense to apply the cache transformation after the map transformation, as long as the resulting dataset can fit into memory or local storage. On the contrary, if the user-defined function increases the space required to store the dataset beyond the cache capacity, either apply it after cash transformation, or consider pre-processing your data before your training job, to reduce resource requirement.

![hpi1](https://i.imgur.com/soJVEiS.png)

![hpi2](https://i.imgur.com/4Hv6IH9.png)

![hpi3](https://i.imgur.com/vmqy1mp.png)

![hpi4](https://i.imgur.com/j1NYn1i.png)

![hpi5](https://i.imgur.com/IhigCTr.png)

![hpi6](https://i.imgur.com/HlORr5d.png)

![hpi7](https://i.imgur.com/7bdY5XX.png)

![hpi8](https://i.imgur.com/cK3cqM3.png)

![hpi9](https://i.imgur.com/IdQdpqy.png)

![hpi10](https://i.imgur.com/mNPFMXA.png)

![hpi11](https://i.imgur.com/hLR5SO3.png)

![hpi12](https://i.imgur.com/yV99Z1N.png)

## Training large models

![tlm1](https://i.imgur.com/enmH7lx.png)

![tlm2](https://i.imgur.com/OBRTRsd.png)

![tlm3](https://i.imgur.com/ijAZ3Sm.png)

![tlm4](https://i.imgur.com/HDlYq0x.png)

![tlm5](https://i.imgur.com/FXPDjRM.png)

![tlm6](https://i.imgur.com/CQaKgR2.png)

## Knowledge Distillation

![kd1](https://i.imgur.com/CQaKgR2.png)

![kd2](https://i.imgur.com/LCEOhuG.png)

![kd3](https://i.imgur.com/mpCQnv6.png)

The way knowledge distillation works is that you transfer knowledge from the teacher to the student by minimizing a loss function, in which the target is the distribution of class probabilities predicted by the teacher model. What happens here is that the teacher models logits form the input to the final softmax layer, which is often used since they provide more information about the probabilities of all target classes for each example. However, in many cases, this probability distribution has the correct class at a very high probability with all the other class probabilities very close to zero. Realistically, it sometimes doesn't provide much information beyond the ground truth labels already provided in the dataset. To tackle this issue, Hinton, Vinyals, and Dean, introduced the concept of a softmax temperature. By raising the temperature in the objective functions of the student and teacher, you can improve the softness of the teacher's distribution. In the formula here, the probability p of class i is calculated from the logits z as shown. T simply refers to the temperature parameter. When t is 1, you get the standard softmax function. But as T starts growing, the probability distribution generated by the softmax function becomes softer, providing more information as to which classes the teacher found more similar to the predicted class. The authors call this the dark knowledge embedded in the teacher model.

![kd4](https://i.imgur.com/VGnWacK.png)

![kd5](https://i.imgur.com/zPuVLBF.png)

![kd6](https://i.imgur.com/yHRwHtO.png)

Here, L is the cross-entropy loss from the hard labels, and L_KL is the Kullback-Leibler divergence loss from the teacher's logits.

![kd7](https://i.imgur.com/mmCAl6B.png)

The authors also found another interesting behavior. It turns out that distilled models are able to produce the correct labels in addition to the teacher's soft targets. That means that you can calculate the standard loss between the student's predicted class probabilities and the ground truth labels. These are known as hard labels or targets. This loss is the student loss. When you're calculating the probabilities for the student, you set the softmax temperature to one

### Example

![kde1](https://i.imgur.com/jruazbn.png)

Researchers at Microsoft proposed a two stage multi teacher knowledge distillation method, or TMKD for short, for a web question answering system. In this approach, they first developed a general Q&amp;A distillation task for student model, pre training. And further fine tune this pre trained student model with a multi teacher knowledge distillation model. The basic knowledge distillation approach presented so far, is known as a one on one model because one teacher transfers knowledge to one student.

Although this approach can effectively reduce the number of parameters and the time for model inference. Due to the information loss during knowledge desolation, the performance of the student model is sometimes not on par with that of the teacher. **This was the driving force for the authors to create a different approach called M on M or many on many ensemble model.** 

Combining both ensemble and knowledge distillation. This involves first training multiple teacher models. The models could be BERT or GPT or others similarly powerful models, each having different hyper parameters. Then a student model for each teacher model is then trained. Finally, the student models trained from different teachers are ensemble to create the final result.

![kde2](https://i.imgur.com/Iim72Gm.png)

THIS IS GENIOUS WTF



## Lab resources

https://googlecoursera.qwiklabs.com/focuses/19773490?parent=lti_session

https://github.com/kubeflow/manifests/tree/v1.1.0/tf-training/tf-job-operator

https://github.com/GoogleCloudPlatform/mlops-on-gcp/tree/master/workshops/mlep-qwiklabs/distributed-training-gke

## Resources

https://ai.googleblog.com/2019/03/introducing-gpipe-open-source-library.html

[Distilling the Knowledge in a Neural Network](https://arxiv.org/pdf/1503.02531.pdf)

[Model Compression with Two-stage Multi-teacher Knowledge
Distillation for Web Question Answering System*](https://arxiv.org/pdf/1910.08381.pdf)

[Noisy Student EfficientNet](https://paperswithcode.com/paper/self-training-with-noisy-student-improves)



## Quiz 1 - High-Performance Modeling

### True Or False: In the model parallelism, the models are replicated into different devices (GPU) and trained on data batches.
1 / 1 point

* False
Correct

!!! note That's right! In model parallelism, you segment the model into different subsections, running concurrently in other nodes, and synchronize the shared parameters on the same training data. 

### Which of the following terminologies are often used in the world of distributed computing? (Select all that apply)
1 / 1 point

* Device
Correct

!!! note That's right! The term device is very commonly used to refer to a CPU or an accelerator like a GPU or TPU on any physical machine which runs machine learning models during different stages of its life cycle.

* Mirrored Variable
Correct

!!! note That's right! When you copy the same variables in the model to multiple devices, they are called mirrored variables. Training methodologies keep these variables in sync across various devices.

* Worker
Correct

!!! note That's right! The term worker is very common and is defined as the accelerator on which some calculations are performed, as in this replica.

### True or False: The pipeline performance can be optimized through parallelizing data extraction and transformation. 
1 / 1 point

* True
Correct

!!! note That’s right! Parallelizing processes, like data extraction or data transformation or both, is a way to accelerate your pipeline performance.

### True or False: TensorFlow offers techniques to optimize pipeline performance like prefetching, parallelizing data extraction and transformation, caching and reducing memory. These techniques are available through the  sklearn.decomposition API.
1 / 1 point

* False
Correct

!!! note That’s correct! The API incorporating prefetching, parallelizing data extraction and transformation, caching and reducing memory is tf.data.

### True Or False: As important developments in both model growth and hardware improvement have been made, parallelism becomes an alternative of greater importance. 
1 / 1 point

* True
Correct

!!! note That’s correct! Even in recent years the size of machine learning models has been increasing, hardware accelerators (like GPUs and TPUs) have also been growing, but at a slower pace.

### The _______ library uses synchronous mini-batch gradient descent for training in a distributed way. 
1 / 1 point

* GPipe
Correct

!!! note That’s right! This distributed machine learning library allows you to make partition models across different accelerators and automatically splits a mini-batch of training examples into smaller micro-batches in a distributed way.

## Quiz 2 - Knowledge Distillation 

### True Or False: The goal of knowledge distillation is optimizing the network implementation:
1 / 1 point

* False
Correct

!!! note Exactly! Rather than optimizing, distillation seeks to create a more efficient model.

### In knowledge distillation, the teacher will be trained using a _________.
1 / 1 point

* A Standard objective function
Correct

!!! note Nailed it! This seeks to maximize the accuracy of the model. 

### True Or False: DistilBERT is a bigger version of BERT with a modified architecture, but the same number of layers. 
1 / 1 point

* False
Correct

!!! note You’re right! it’s a smaller version of BERT: they reduced the numbers of layers and kept the rest of the architecture identical

### True Or False: In knowledge distillation, the “teacher” network is deployed in production as it is able to mimic the complex feature relationships of the “student” network.
1 / 1 point

* False
Correct

!!! note Exactly! It’s actually the “student” network the one deployed to mimic the “teacher” network.

### For a multi-class classification problem, which ones of the following statements are true regarding the training cost functions of the “student” and the “teacher” networks? (Select all that apply)
1 / 1 point

* The teacher network is trained to maximize its accuracy and the the student network uses a cost function to approximate the probability distributions of the predictions of the teacher network.
Correct

!!! note That's right!

* Soft targets encode more information about the knowledge learned by the teacher than its output class prediction per example.
Correct

!!! note That's right! Soft targets provide more information that the output class predicted per example as they include information about all the classes per training example through the probability distribution.

### When the softmax temperature ____, the soft targets defined by the teacher network become less informative
1 / 1 point

* decreases 
Correct

!!! note That's right! The softness of the teacher’s distribution is worse, thus less informative.

### Generally, knowledge distillation is done by blending two loss functions and involves several hyperparameters. Here, L_h is the cross-entropy loss from the hard labels and LKL is the Kullback–Leibler divergence loss from the teacher labels. Which of the following statements are correct about the hyperparameters of knowledge distillation? (Select all that apply)
1 / 1 point

* In case of heavy data augmentation after training the teacher network, the alpha hyperparameter should be high in the student network loss function
Correct

!!! note That’s correct! This high alpha parameter would reduce the influence of the hard labels that went through aggressive perturbations due to data augmentation

* When computing the the "standard" loss between the student's predicted class probabilities and the ground-truth “hard” labels, we use a value of the softmax temperature T equal to 1 
Correct

!!! note That’s right! This way, the student loss function would be a classical softmax function
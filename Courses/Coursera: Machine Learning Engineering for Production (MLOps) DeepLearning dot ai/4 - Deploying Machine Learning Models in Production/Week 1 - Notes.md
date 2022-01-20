# Model Serving

- [Model Serving](#model-serving)
  - [What and why model serving?](#what-and-why-model-serving)
  - [Quiz 1 - Introduction to Model Serving](#quiz-1---introduction-to-model-serving)
    - [What are the three key components we should consider when serving an ML Model in a production environment? (Select all that apply)](#what-are-the-three-key-components-we-should-consider-when-serving-an-ml-model-in-a-production-environment-select-all-that-apply)
    - [What happens after a while in operation to an offline-trained model dealing with new real-live data?](#what-happens-after-a-while-in-operation-to-an-offline-trained-model-dealing-with-new-real-live-data)
    - [In applications that are not user-facing, is throughput more critical than latency for customer satisfaction?](#in-applications-that-are-not-user-facing-is-throughput-more-critical-than-latency-for-customer-satisfaction)
    - [Nowadays, developers aim to minimize latency and maximize throughput in customer-facing applications. However, in doing so, infrastructure scales and costs increase. So, what strategies can developers implement to balance cost and customer satisfaction? (Select all that apply)](#nowadays-developers-aim-to-minimize-latency-and-maximize-throughput-in-customer-facing-applications-however-in-doing-so-infrastructure-scales-and-costs-increase-so-what-strategies-can-developers-implement-to-balance-cost-and-customer-satisfaction-select-all-that-apply)

## What and why model serving?

![ms1](https://i.imgur.com/Ldu3JqP.png)

![ms2](https://i.imgur.com/7coZ5ik.png)

![ms3](https://i.imgur.com/CwtLs28.png)

![ms4](https://i.imgur.com/SoisoVd.png)

![ms5](https://i.imgur.com/Mgsav7v.png)

![ms6](https://i.imgur.com/gWyL3wO.png)

![ms7](https://i.imgur.com/89H0ZoQ.png)

![ms8](https://i.imgur.com/jtDfgSe.png)

## Quiz 1 - Introduction to Model Serving

### What are the three key components we should consider when serving an ML Model in a production environment? (Select all that apply)
1 / 1 point

Input Data
Correct

You’ve got it!  The model executed on-device makes predictions based on the input data.

An interpreter
Correct

Right on track! An Interpreter encapsulates a pre-trained model in which operations are executed for inference.

An orchestrator

A model
Correct

Correct! Providing the algorithm and training the ML model is the first step towards putting it into production.

### What happens after a while in operation to an offline-trained model dealing with new real-live data?
1 / 1 point

The model adapts to new patterns.

The model becomes stale.

The model abruptly forgets all previously learned information.
Correct

Good job!  The model performance deteriorates to the point of the model not being any longer fit for purpose. This phenomenon is called model decay and should be carefully monitored.

### In applications that are not user-facing, is throughput more critical than latency for customer satisfaction?
1 / 1 point

No, because users might complain that the app is too slow.

Yes, in this case, we are concerned with maximizing throughput with the lowest CPU usage.
Correct

Correct! Latency is not a key concern for back-end services.

### Nowadays, developers aim to minimize latency and maximize throughput in customer-facing applications. However, in doing so, infrastructure scales and costs increase. So, what strategies can developers implement to balance cost and customer satisfaction? (Select all that apply)
1 / 1 point

GPU sharing
Correct

Nailed it! This strategy reduces the cost of GPU-accelerated computing.

Multi-model serving
Correct

Yes! This approach scales back infrastructure.

!!! note Optimizing inference models
Correct

Right on track! Optimization modifies a model to handle a higher load, reducing costs as a result.
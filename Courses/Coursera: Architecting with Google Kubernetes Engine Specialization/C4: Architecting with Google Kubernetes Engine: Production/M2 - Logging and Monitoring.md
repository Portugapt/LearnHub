- [Logging and Monitoring](#logging-and-monitoring)
  - [Operations Suite](#operations-suite)
    - [Quiz](#quiz)
  - [Logging](#logging)
    - [Cluster logging](#cluster-logging)
    - [Quiz](#quiz-1)
  - [Monitoring](#monitoring)
    - [Quiz](#quiz-2)
  - [Lab: Configuring GKE-Native Monitoring and Logging](#lab-configuring-gke-native-monitoring-and-logging)
  - [Probes](#probes)

# Logging and Monitoring

## Operations Suite

Using stackdriver

![whatiwillleran](https://i.imgur.com/FQ267TA.png)

The stack of logging tools by google:  
![stacklg](https://i.imgur.com/kyyZTiS.png)

Whats connected to Cloud Logging:  

![whyuselogging](https://i.imgur.com/d5NYeDx.png)

What's the advantage of Cloud Monitoring:  

![whyusemonitoring](https://i.imgur.com/dq6U7dr.png)


Cloud Debugger is also a helpful tool
![cdebugger](https://i.imgur.com/3j1YGGk.png)

### Quiz

Why would someone consider exporting log data from Cloud Logging to Bigquery or Cloud Storage?  

- [ ] For the creation of custom dashboards.
- [X] For more complex analysis.
- [X] Set up a host project for Operations, and use it to monitor the other projects.

Question 2

If your organization has multiple Google Cloud projects, what is the recommended best practice for logging and monitoring?

## Logging

50gb of logging is free.  
Logging uplodaded to Cloud Logging

If you want the most recent logs for the events that are happening right now then the kubectl logs command will give you those logs. However, if you want to find and examine logs for past events or over a period of time in the last 30 days then Stackdriver gives you the tools to find and examine those logs. If you let Stackdriver handle the logs, you will broaden the visibility of GKE events and be able to correlate issues better. You'll have a single interface where you can review the logs from your containers, nodes, and other system services. Note that although Stackdriver does collect these logs, the data isn't kept in Stackdriver forever. After 30 days, it's purged. If you want to keep the data longer, remember to export the logs to Cloud Storage or BigQuery for long-term analysis. 
![useless1](https://i.imgur.com/zsxBOqN.png)

![dontcommentcode2](https://i.imgur.com/fzIsTHv.png)

### Cluster logging

If the container is deleted from the node, all of the logs are deleted when the container is deleted from the node. If a pod is deleted from the node, all corresponding containers are also deleted along with our logs which leaves you without any logs unless you have used a central log management utility such as Cloud LOgging. Now let's discuss cloud logging.

![lk8s](https://i.imgur.com/S5UQSYv.png)

![whatfluentd](https://i.imgur.com/dVZPcZo.png)

FluentD is a DaemonSet.  

### Quiz

By default, how long does log information remain on GKE nodes?

- 1 day or less, depending on log volume

By default, how long does log information remain in Cloud Logging?

- Exactly 30 days

## Monitoring

SRE ( site reliability engineering )

This diagram shows what depends on what, the activity at a given level depends on what's beneath it. Notice that monitoring is the most fundamental layer of the service reliability hierarchy.

![mon1](https://i.imgur.com/uXraWk4.png)

Unlike traditional server monitoring where you can specify a host name to monitor, the abstraction layers in kubernetes while containers in general. Force you to change your approach instead of having a specific host name or iP address to be monitored. All resources in kubernetes have labels that you define to create a logical structure, these labels give you a logical approach to organizing your resources. They also make it easier for you to monitor specific systems or subsystems by selecting a combination of different labels. In stack driver and other tools you can filter the logs and focus the monitoring on components that match a given label. Here's an example remember that kubernetes labels consist of a key and a value. You could apply a label consisting of the key environment and the value production, to all the components of your production environment and then use that label in stock driver.

A lot of existing applications built for kubernetes. Use an open source tool to expose custom metrics, stock driver offers a Prometheus collector. You install it in your cluster in the same kubernetes pod as your Prometheus savour.
This way,
data from Prometheus is available as external metrics in stock driver. 


### Quiz

How is monitoring in Kubernetes typically structured?

- By labels

What is the role of Prometheus in a Kubernetes cluster?

- To allow applications to expose application-specific metrics.

## Lab: Configuring GKE-Native Monitoring and Logging  

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1/Monitoring

## Probes
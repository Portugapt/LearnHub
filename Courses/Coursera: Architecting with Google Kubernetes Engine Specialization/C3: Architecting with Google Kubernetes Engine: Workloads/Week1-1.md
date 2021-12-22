- [The kubectl command](#the-kubectl-command)
- [Lab 1](#lab-1)
- [Deployments, Jobs, Cronjobs, Scaling, Controlling](#deployments-jobs-cronjobs-scaling-controlling)
  - [How to deploy](#how-to-deploy)
  - [Horizontal Pod Autoscaler](#horizontal-pod-autoscaler)
  - [Update a deployment.](#update-a-deployment)
  - [Blue-Green deployment](#blue-green-deployment)
  - [Canary deployment](#canary-deployment)
  - [Rollback](#rollback)
  - [Pause a rollout](#pause-a-rollout)
  - [Deployment Lab](#deployment-lab)
  - [Jobs and Cron Jobs](#jobs-and-cron-jobs)
  - [Jobs Lab](#jobs-lab)
  - [Scaling](#scaling)
  - [Pod placement](#pod-placement)
    - [Taint](#taint)
  - [Affinity Lab](#affinity-lab)
- [Quiz Deployments, Jobs, and Scaling](#quiz-deployments-jobs-and-scaling)

# The kubectl command

![kube1](https://i.imgur.com/q9yz0nt.png)

- use it to communicate with the kube apiserver on your control-plane
- kubectl must be configured with a location and credentials of a Kubernetes cluster.

![commands](https://i.imgur.com/gmOoH9k.png)

First, log in through gcloud and choose the cluster (or create it.). This is called kubeconfig (https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#generate_kubeconfig_entry)

![gcloudlog](https://i.imgur.com/k4Bmr04.png)

-------------

![mainkubes](https://i.imgur.com/aePOZPl.png)

You could retrieve a list of objects using a command like kubectl get pods,
which returns a list of all of the pods in the cluster and tells you their status.
For more information on a specific pod,
run the command kubectl describe my-pod-name,
which gives you detailed information about the pod named my-pod-name.
You can even test and debug within your pod using the kubectl exec
my-pod-name command to execute commands and applications.
The logs command provides a powerful tool to see what's happening inside a pod.
Logs are always useful in troubleshooting.
The log command allows you to quickly and easily view errors or
debugging messages written out by the applications running inside pods. 


Work on a container to understand whats wrong.
![exec1](https://i.imgur.com/5xLPl4U.png)

# Lab 1

Create a Kubernetes cluster.   
`gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias`

Resize the cluster   
`gcloud container clusters resize $my_cluster --zone $my_zone --num-nodes=4`

To create a kubeconfig file with the credentials of the current user (to allow authentication) and provide the endpoint details for a specific cluster (to allow communicating with that cluster through the kubectl command-line tool), execute the following command:   
`gcloud container clusters get-credentials $my_cluster --zone $my_zone`


Command to print out the content of the kubeconfig file:   
`kubectl config view`

Command to enable bash autocompletion for kubectl:
`source <(kubectl completion bash)`

Command to deploy nginx as a Pod named nginx-1:
`kubectl create deployment --image nginx nginx-1`


Check-out the status of the deployed image:
```bash
kubectl describe pod $my_nginx_pod
```

Create and put a test file in the container:  
```bash 
nano ~/test.html
```

```html
<html> <header><title>This is title</title></header>
<body> Hello world </body>
</html>
```
```bash
kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html
```

Expose the pod to the network
```bash
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer
```

If I have an YAML:
```bash
kubectl apply -f ./new-nginx-pod.yaml
```

access this pod:
```bash
kubectl exec -it new-nginx /bin/bash
```

You want to use kubectl to configure your cluster, but first you must configure it. Where does the kubectl command store its configuration file?
* The configuration information is stored in the $HOME/.kube/config file.



You attempt to update a container image to a new version, but this does not succeed. You execute the command 'kubectl describe pod  '. The output of the command shows that the Pod status has changed to Pending, the state is shown as Waiting and the reason shown is ImagePullBackOff. What is the most probable cause of this error?
* The container image failed to download.

You want to use a kubectl get command to identify which Node each Pod is running on.  Which command do you need to execute?
* kubectl get pods -o=wide



Which command can you use to look at the error messages from containers in a Pod that are failing to run successfully?
* kubectl logs 


What command can you use to identify which containers in a Pod are successfully running, and which are failing or having issues?
* kubectl describe pod 

You are troubleshooting a network issue, but before you can do this, you need to launch an interactive shell inside an existing Pod in order to install a network monitoring tool. Which kubectl command should you execute in order to achieve this goal?
* kubectl exec -it   -- /bin/bash

# Deployments, Jobs, Cronjobs, Scaling, Controlling

![deploy](https://i.imgur.com/oc52djp.png)

Every time you update the specification of the Pods, for example, updating them to a newer Container Image, a new ReplicaSet is created that matches the altered version of the deployment. 
This is how deployments rollout updated Pods in a controlled manner. Old Pods are removed from the old ReplicaSet and replaced with newer Pods in a new ReplicaSet. 

Deployments are designed for stateless applications. Stateless applications don't store data or application state to a cluster or to persistent storage. A typical example of a stateless application is a web front-end. 

Deployment yaml file.  
![yamldeploy](https://i.imgur.com/RLgkmf2.png)

![statesofdeploy](https://i.imgur.com/IniSa0S.png)

## How to deploy

![depl1](https://i.imgur.com/hlQlq9N.png)

Get deployment file from current deployment.

![deploy2](https://i.imgur.com/04L2F0Y.png)

## Horizontal Pod Autoscaler

![hpa](https://i.imgur.com/HKvxX7t.png)
Keep in mind that we're not scaling the cluster as a whole, just a particular deployment within that cluster.

What is the relationship between Deployments and ReplicaSets?
- [ ] A Deployment configures a ReplicaSet controller to create and maintain all the Pods that the Deployment specifies, regardless of their version.
- [ ] There is no relationship; in modern Kubernetes, Replication Controllers are typically used to maintain a set of Pods in a running state.
- [ ] A ReplicaSet configures a Deployment controller to create and maintain a specific version of the Pods that the Deployment specifies.
- [X] A Deployment configures a ReplicaSet controller to create and maintain a specific version of the Pods that the Deployment specifies.

What type of application is suited for use with a Deployment?
* Stateless

## Update a deployment.

**Rollout in a pod specification.**

when you make a change to a deployment spot specifications such as changing the image version and automatic update rollout what happens. 

Rolling / Ramped update

![rru](https://i.imgur.com/3jcUBQc.png)

## Blue-Green deployment

![bgdep](https://i.imgur.com/Ock40Yx.png)

![howtobgdep](https://i.imgur.com/klEoM6W.png)

## Canary deployment

Test rollout before full deployment
![candep](https://i.imgur.com/ILH3r06.png)

![candep2](https://i.imgur.com/keJjMBT.png)

## Rollback

![rollbackdep](https://i.imgur.com/VZfUsN5.png)

## Pause a rollout

![pauseroll](https://i.imgur.com/LTjeEZa.png)

## Deployment Lab

```bash
kubectl scale --replicas=3 deployment nginx-deployment
```


update the version of nginx in the deployment, execute the following command:   
```bash
kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record
```   

To view the rollout status, execute the following command:
```bash
kubectl rollout status deployment.v1.apps/nginx-deployment
```

View the rollout history of the deployment.
```bash
kubectl rollout history deployment nginx-deployment
```

**To roll back to the previous version of the nginx deployment, execute the following command:**   
```bash
kubectl rollout undo deployments nginx-deployment
```

Canary deployment yaml:   
https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/ak8s/v1.1/Deployments/nginx-canary.yaml

## Jobs and Cron Jobs

Job Controller monitors de pod. Task completed or not?  
change to another node on failure.
![jobsparallel](https://i.imgur.com/E2YiZpr.png)

![jobcommands](https://i.imgur.com/niMuRzp.png)

## Jobs Lab

Initial commands
```bash
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Jobs_CronJobs
```

run the job  
`kubectl apply -f example-job.yaml`  
and check it out  
`kubectl describe job example-job`

The cron job  
`kubectl apply -f example-cronjob.yaml`

## Scaling

![type1scaling](https://i.imgur.com/SWcfVp7.png)

![consolescaling](https://i.imgur.com/TaOtAtC.png)

![autoscaling](https://i.imgur.com/7Llkjw5.png)

Autoscaling required VM's to start up (new nodes) which takes time. And scaling down can disrupt the service a bit because a node is shutting down.  
This nodes are shut down gracefully.

> Deploying a part to an existing running node may only take a few seconds, but it might take minutes before the new node added by the autoscaler can be used, and adding nodes means spending more money too. You should think of a cluster scaling as a coarse-grained operation that should happen infrequently and pod scaling with deployments as a fine-grained operation that should happen frequently.

![whymypodnogone](https://i.imgur.com/XGD2gbc.png)

![boom1](https://i.imgur.com/K4z37Fp.png)

![bestpracticesautoscaler](https://i.imgur.com/TAcZNWX.png)

![nodepoolscaling](https://i.imgur.com/wf2Lcq2.png)

## Pod placement

![specifypod](https://i.imgur.com/PLu9HvR.png)

One must define how much resources a container needs to run normally, so that the controllers can better distribute the pods across nodes.  

![labelmatching](https://i.imgur.com/83kxbq7.png)
Pods can have attributes that specify certain requirements, e.g. the need for an SSD.  
This means only nodes that have ssd's will receive the allocation of these pods.  

![affinity](https://i.imgur.com/fE00lPr.png)
Affinity and anti-affinity are like soft-requirements for the pods. Instead of preventing the pod from starting at all, it allows some margin.

![repel](https://i.imgur.com/wv9SAcB.png)

### Taint

![taint1](https://i.imgur.com/krntUG7.png)

![taint2](https://i.imgur.com/pHpVsmJ.png)

The same as affinity but for nodes.

We can use node pools to abtract away some of this fine-grained complexity.  

## Affinity Lab

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1/Autoscaling

```bash
kubectl create -f web.yaml --save-config

kubectl expose deployment web --target-port=8080 --type=NodePort
```

Add node pool

```bash
gcloud container node-pools create "temp-pool-1" \
--cluster=$my_cluster --zone=$my_zone \
--num-nodes "2" --node-labels=temp=true --preemptible
```
# Quiz Deployments, Jobs, and Scaling

- After a Deployment has been created and its component Pods are running, which component is responsible for ensuring that a replacement Pod is launched whenever a Pod fails or is evicted?

ReplicaSet

-----

- You are configuring the rollout strategy for your Deployment that contains 8 Pods. You need to specify a Deployment property that will ensure at least 75% of the desired number of Pods is always running at the same time. What property and value should you set for the deployment to ensure that this is the case?

maxUnavailable=25%

-----

- You have made a number of changes to your deployment and applied those changes. Which command should you use to rollback the environment to the deployment identified in the deployment history as revision 2?

Run 'kubectl rollout undo deployment   --to-revision=2'.

-----

- You are resolving a range of issues with a Deployment and need to make a large number of changes. Which command can you execute to group these changes into a single rollout, thus avoiding pushing out a large number of rollouts?

kubectl rollout resume deployment WRONG  
kubectl rollout pause deployment 

-----

- You are configuring a Job to process the conversion of a sample of a large number of video files from one format to another. Which parameter should you configure to ensure that you stop processing once a sufficient quantity have been processed?

completions=4

-----

- You have configured a Kubernetes Job with a backofflimit of 4 and a completions count of 8. If the Pods launched by the Job continually fail, how long does it take for four failures to happen and what does the Job report?

40 seconds, Job fails with BackoffLimitExceeded as the reason. WRONG   
80 seconds, Job fails with BackoffLimitExceeded as the reason.

-----

- A parallel Kubernetes Job is configured with parallelism of property of 4 and a completions property of 9. How many Pods are kept in a running state by the Job controller immediately after the sixth successful completion?

"The actual number of Pods running in a steady state might be less than the parallelism value if the remaining work is less than the parallelism value."  
https://cloud.google.com/kubernetes-engine/docs/how-to/jobs#job_completion_count  

3

-----

- With a Kubernetes Job configured with a parallelism value of 3 and no completion count what happens to the status of the Job when one of the Pods successfully terminates?

"Omitting completions or specifying a zero value causes the success of any Pod to signal the success of all Pods."  

The entire Job is considered complete and the remaining Pods are shut down.  

-----

- How do you configure a Kubernetes Job so that Pods are retained after completion?

https://kubernetes.io/docs/concepts/workloads/controllers/job/#job-termination-and-cleanup

"The activeDeadlineSeconds applies to the duration of the job, no matter how many Pods are created." 

Set a startingDeadlineSeconds value high enough to allow you to access the logs. WRONG   
Configure the cascade flag for the Job with a value of false.

-----

- You have autoscaling enabled on your cluster. What conditions are required for the autoscaler to decide to delete a node?

If a node is underutilized and there are no Pods currently running on the Node. WRONG    
If a node is underutilized and running Pods can be run on other Nodes. 

-----

- What status or event is used by the GKE autoscaler to decide when scaleout is required and a new node needs to added?

When the scheduler cannot schedule a Pod due to resource constraints and the Pod has been marked as unschedulable.

-----

- When specifying Inter-pod affinity rules, you need to specify an affinity rule at the zone level, not at the individual Node level. Which additional parameter in the Pod manifest YAML must you set to apply this override?

topologyKey: failure-domain.beta.kubernetes.io/zone

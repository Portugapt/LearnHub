# Kubernetes

![kube1](https://i.imgur.com/8b13325.png)
> gcloud container clusters create k1
- Can be created using GKE

Node - computing instance

> To use Kubernetes, you can describe a set of applications and how they should
interact with each other, and Kubernetes figures out how to make that happen.

![pods](https://i.imgur.com/hVIcxs3.png)

- Can have multiple hard dependecy containers in a single pod.
- Pod is the smallest deployment unit.

- `kubectl run` to run a container in a pod.

![deploy1](https://i.imgur.com/J2fHREe.png)

>By default, pods in a deployment or
only accessible inside your cluster, but what if you want people on
the Internet to be able to access the content in your nginx web server?
To make the pods in your deployment publicly available,
you can connect a load balancer to it by running the kubectl expose command.

![deploy2](https://i.imgur.com/xk5NmHw.png)


`autoscale`, `replicas`, `get pods` are all commands I need to get used to.

rollingUpdate is to roll out updates gradually
>You do not want your users to experience downtime
while your application rebuilds and redeploys.
That's why one attribute of a deployment is its update strategy.
Here's an example, a rolling update.
When you choose a rolling update for a deployment and
then give it a new version of the software that it manages,
Kubernetes will create pods of the new version one-by-one, waiting for each
new version pod to become available before destroying one of the old version pods.
Rolling updates are a quick way to push out a new version of your
application while still sparing your users from experiencing downtime. 

# Anthos

Multi-cloud service.
![anthos1](https://i.imgur.com/LWctNJk.png)

![anthosstack](https://i.imgur.com/6Qtqz9H.png)

----
Lab

Start a Kubernetes cluster managed by Kubernetes Engine. Name the cluster webfrontend and configure it to run 2 nodes:  
`gcloud container clusters create webfrontend --zone $MY_ZONE --num-nodes 2`

Run and deploy a container

    From your Cloud Shell prompt, launch a single instance of the nginx container. (Nginx is a popular web server.)

`kubectl create deploy nginx --image=nginx:1.17.10`

> How does it know I'm asking to deploy on webfrontend cluster?

n Kubernetes, all containers run in pods. This use of the kubectl create command caused Kubernetes to create a deployment consisting of a single pod containing the nginx container. A Kubernetes deployment keeps a given number of pods up and running even in the event of failures among the nodes on which they run. In this command, you launched the default number of pods, which is 1.


`kubectl get pods`
>NAME                     READY   STATUS    RESTARTS   AGE
>nginx-674c77bcbb-qhhf8   1/1     Running   0          100s

Expose the nginx container to the Internet:
`kubectl expose deployment nginx --port 80 --type LoadBalancer`


`kubectl get services`
To check out external IP of just deployed server.


> How does it know I'm asking to deploy on webfrontend cluster?
> What does nginx do to be the external IP gate?


# App Engine

![appenginestandard](https://i.imgur.com/TLB5rtT.png)

![appengcompar](https://i.imgur.com/g9dyGTI.png)

![difftokuber](https://i.imgur.com/QLNUy81.png)


2 API management tools

- Cloud Endpoints 
  -  Which enduser is making the call.
  -  Uses Proxies
  -  Has API Console
- Apigee
  - Enterprise
  - analytics, monetization, develop
  - Peel off monolitic to microservice architecture overtime.
# App Engine Lab
Initialize your App Engine app with your project and choose its region:
`gcloud app create --project=$DEVSHELL_PROJECT_ID`

Go to location of files (e.g. cloned repo) (`git clone https://github.com/GoogleCloudPlatform/python-docs-samples`)

`gcloud app deploy`

# Cloud Functions

- Event-triggered functions that can enhance microservices.
- Works with Cloud Storage, Pub/Sub and HTTP requests.
- On 100ms intervals.
-  handles scaling these components seamlessly.

# Cloud Source

- IAM permissions
- Git repository inside projects
- Keeps code private and hierarchical.

# Deployment manager

![dmme](https://i.imgur.com/lIZwl0I.png)

# Stackdriver

![sd1](https://i.imgur.com/GAjCiUi.png)

![sd2](https://i.imgur.com/3nz2zjP.png)

# Lab Deployment Manager and Cloud Monitoring

`gsutil cp gs://cloud-training/gcpfcoreinfra/mydeploy.yaml mydeploy.yaml`

In the Cloud Shell, use the sed command to replace the PROJECT_ID placeholder string with your Google Cloud Platform project ID using this command:
`sed -i -e "s/PROJECT_ID/$DEVSHELL_PROJECT_ID/" mydeploy.yaml`

In the Cloud Shell, use the sed command to replace the ZONE placeholder string with your Google Cloud Platform zone using this command:
`sed -i -e "s/ZONE/$MY_ZONE/" mydeploy.yaml`

Build deployment from this template:
`gcloud deployment-manager deployments create my-first-depl --config mydeploy.yaml`

# Big Data platform

![bdpalat](https://i.imgur.com/xu2FFxq.png)

dataflow example:
![dataflow1](https://i.imgur.com/vGWy8XV.png)
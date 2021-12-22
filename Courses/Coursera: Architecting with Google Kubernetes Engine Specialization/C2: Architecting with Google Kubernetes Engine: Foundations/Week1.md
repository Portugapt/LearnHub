
Set computation (VM's) zone.

`gcloud config set compute/zone $MY_ZONE`

Set roles through shell
`gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer`

# Cloud Build Lab

`nano quickstart.sh`

```bash
#!/bin/sh
echo "Hello, world! The time is $(date)."
```

`nano Dockerfile`

```bash
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
```


In Cloud Shell, run the following command to make the quickstart.sh script executable.
`chmod +x quickstart.sh`

In Cloud Shell, run the following command to build the Docker container image in Cloud Build.
`gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/quickstart-image .`

![img1](https://i.imgur.com/0YeKZmA.png)

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1

yaml:
This file instructs Cloud Build to use Docker to build an image using the Dockerfile specification in the current local directory, tag it with gcr.io/$PROJECT_ID/quickstart-image ($PROJECT_ID is a substitution variable automatically populated by Cloud Build with the project ID of the associated project) and then push that image to Container Registry.

Saber escrever yamls.
Templates de um futuro.

# GKE

![gke2](https://i.imgur.com/affaR86.png)

- GKE is fully managed, which means that you don't have to provision the underlying resources.
GKE uses a container optimized operating system. These operating systems are maintained by Google, they are optimized to scale quickly and with a minimal resource footprint.
- The container optimized OS, it will be discussed later on in this course. When you use GKE, you start by directing the service to instantiate a kubernetes system for you. This system is called a cluster, 
- GKE's auto upgrade feature can be enabled to ensure that your clusters are automatically upgraded with the latest and greatest version of kubernetes.
The virtual machines that host your containers
inside of a GKE cluster are called nodes.
If you enable GKE's auto repair feature,
the service will automatically repair unhealthy notes for you.
It'll make periodic health checks on each node in the cluster.
If a node is determined to be unhealthy and requires repair,
GKE will drain the node.
In other words,
it will cause it's workloads to gracefully exit and then recreate that node.
Just as kubernetes supports scaling workloads,
GKE supports scaling the cluster itself.
GKE seamlessly integrates with Google clouds build and container registry.
This allows you to automate deployment using private container images that you've
securely stored in container registry.
- GKE also integrates with Google's identity and access management,
which allows you to control access through the use of accounts and role permissions.
- Stack driver, this Google cloud system for monitoring and management for services,
containers, applications and infrastructure. GKE integrates with stack driver monitoring to help you
understand your application's performance.
- GKE is integrated with Google virtual private clouds or VPC's, it makes use of GCP's networking features.
- And finally, the GCP console provides insights into GKE clusters and the resources and allows you to view, inspect and delete resources in those clusters.
- 
You might be aware that open source kubernetes contains a dashboard, but
it takes a lot of work to set it up securely.
But the GCP console is a dashboard for your GKE clusters and workloads they don't
have to manage, it's more powerful than the kubernetes dashboard. 

# Kubernetes concepts

kubeadm

![kube1](https://i.imgur.com/eJQ1HLO.png)

Note pools

![kube2](https://i.imgur.com/3t9NYnD.png)

Regional vs Zone 

![kube3](https://i.imgur.com/grg32fJ.png)

## Object management

![kubeom1](https://i.imgur.com/w5hrpWe.png)

![podlife](https://i.imgur.com/RVkBPnl.png)

![podcontrol](https://i.imgur.com/nqPnD7e.png)

![yaml1](https://i.imgur.com/SULTTgH.png)
If the desired state is not the current one, k8 will try to launch a new pod to fix that.

Namespaces
![namespaces](https://i.imgur.com/HyC69Ka.png)

What is the purpose of the Deployment object

- To ensure that a defined set of Pods is running at any given time.

Services provide load-balanced access to specified Pods. There are three primary types of Services:

    ClusterIP: Exposes the service on an IP address that is only accessible from within this cluster. This is the default type.

    NodePort: Exposes the service on the IP address of each node in the cluster, at a specific port number.

    LoadBalancer: Exposes the service externally, using a load balancing service provided by a cloud provider. 

In Google Kubernetes Engine, LoadBalancers give you access to a regional Network Load Balancing configuration by default. To get access to a global HTTP(S) Load Balancing configuration, you can use an Ingress object.

# Kubernetes

Navigation menu, click Kubernetes Engine > Clusters.

Criar cluster

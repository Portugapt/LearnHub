
- [How to create services and expose them](#how-to-create-services-and-expose-them)
  - [Pod Networking](#pod-networking)
  - [Services](#services)
  - [Services Types and Load Balancer](#services-types-and-load-balancer)
    - [ClusterIP Services](#clusterip-services)
    - [NodePort Services](#nodeport-services)
    - [Load Balancer Services](#load-balancer-services)
  - [Ingress Resource](#ingress-resource)
  - [Security](#security)
  - [LAB: Configuring Google Kubernetes Engine (GKE) Networking](#lab-configuring-google-kubernetes-engine-gke-networking)
    - [Add an authorized network for cluster master access](#add-an-authorized-network-for-cluster-master-access)
    - [Create a cluster network policy](#create-a-cluster-network-policy)
  - [LAB: Creating Services and Ingress Resources](#lab-creating-services-and-ingress-resources)
    - [Create Pods and services to test DNS resolution](#create-pods-and-services-to-test-dns-resolution)
  - [QUIZ: Google Kubernetes Engine Networking](#quiz-google-kubernetes-engine-networking)



# How to create services and expose them

![wwwl](https://i.imgur.com/G5tRzXd.png)

## Pod Networking

![insidaapod](https://i.imgur.com/8GlrxQl.png)

Inside a pod, a nginx can contact with other applications

Remember a pod is a group of containers with shared storage and networking. This is based on the IP per pod model of kubernetes. With this model, each part is assigned a single IP address and the containers within a pod share the same network name space, including that IP address. For example, you might have a legacy application that uses nginx as a reverse proxy for client access. The nginx container runs on tcp port 80. And the legacy application runs on tcp port 8000. Because both containers ...

![problem1](https://i.imgur.com/LvUoHfA.png)

Each pod has an unique IP address. 
On a node, the pods are connected to each other to the nodes route network name space, which ensures that the pods can find and reach each other on that VM. 

![sol1](https://i.imgur.com/FV4dgAg.png)

![sol2](https://i.imgur.com/fQDITus.png)

![sol3](https://i.imgur.com/5HaqoIq.png)

![sol4](https://i.imgur.com/CVcgkbL.png)

That means that the pods can directly connect to each other using their native IP addresses. Pod IP addresses are natively routable within the clusters VPC network. And other VPC networks connected to it by VPC network peering. The traffic from your clusters is routed or peered inside Google Cloud but becomes not translated at the node IP address if it has to exit Google Cloud.
![sol5](https://i.imgur.com/Fn5kfd0.png)

Which statement is true about Kubernetes networking?  
Each Pod in a cluster has a unique IP address.

In GKE, what is the source of the IP addresses for Pods?  
Address ranges assigned to your Virtual Private Cloud

## Services  

services give pods a stable IP address and name that remains the same through updates, upgrades, scalability changes, and even pod failures. Instead of connecting to a specific pod, applications on Kubernetes rely on services to locate suitable pods and forward the traffic, we add those services rather than directly to pods.


LABEL SELECTOR

![services1](https://i.imgur.com/DgzlOSw.png)

![services2](https://i.imgur.com/aC8NXz9.png)

![services3](https://i.imgur.com/caF8Wdq.png)

![services4](https://i.imgur.com/mpPrgGQ.png)

## Services Types and Load Balancer

![sum1](https://i.imgur.com/DZXbIKK.png)

What is the main use of a Service of type ClusterIP?   
Internal communication within a cluster

What is the difference between a Service of type ClusterIP and one of type NodePort?  
In addition to exposing the service at a particular cluster IP address, a NodePort Service also exposes the service on every node at a particular port number.  

What is the main use of a Service of type LoadBalancer?   
Exposing services outside a cluster

### ClusterIP Services
Define the Service
![cIP1](https://i.imgur.com/KnDRXd1.png)

How it flows
![cipflow](https://i.imgur.com/8Xb3pTd.png)

### NodePort Services
Internal communication within a cluster

![np1](https://i.imgur.com/EeXVWNp.png)

![np2](https://i.imgur.com/pNTbDh2.png)

### Load Balancer Services

![lb1](https://i.imgur.com/oDDkxq2.png)

![lb2](https://i.imgur.com/crXWEHl.png)

## Ingress Resource

A service for services


![ingress1](https://i.imgur.com/8QuUYA1.png)

In GKE, an Ingress resource exposes these services using a single public IP address bound to a HTTP or HTTPS load balancer provisioned within Google Cloud.

![ig2](https://i.imgur.com/rILyMvC.png)

## Security

![secpolicy](https://i.imgur.com/GAVCVU5.png)
![secpolicy2](https://i.imgur.com/LoCq0Kg.png)

![sec1](https://i.imgur.com/quZ4eKE.png)
![sec2](https://i.imgur.com/OR4535S.png)

![secdefault](https://i.imgur.com/PDGjWre.png)

What is the purpose of enabling network policies in a Kubernetes cluster?  
To restrict network access from a Pod to other Pods and Services inside the cluster

## LAB: Configuring Google Kubernetes Engine (GKE) Networking 

https://googlecoursera.qwiklabs.com/focuses/19360664?parent=lti_session


 * On the Navigation menu (8c24be286e75dbe7.png), click Kubernetes Engine > Clusters.
* Click Create.
* Click Configure to select Standard mode for the cluster.
* Name the cluster private-cluster.
* Select us-central1-a as the zone.
* Click on default-pool under NODE POOLS section and then enter 2 in Number of nodes section.
* Click on Networking section, select Enable VPC-native traffic routing (uses alias IP).
* In the Networking section, select Private cluster and select Access control plane using its external IP address.
* For Control plane IP Range, enter 172.16.0.0/28.
  * Note: This step assumes that you don't have this range assigned to a subnet. Check VPC Networks in the Google Cloud Console, and select a different range if necessary. Behind the scenes, Google Cloud uses VPC peering to connect the VPC of the cluster master with your default VPC network.  
* Deselect Enable control plane authorized networks.

### Add an authorized network for cluster master access

Edit control plane authorized networks 


* In the Google Cloud Console Navigation menu (8c24be286e75dbe7.png), click Kubernetes Engine > Clusters.
* Click private-cluster to open the Clusters details page.
* In Details tab, for Control plane authorized networks click on the Edit(pencil-icon.png).
* Select Enable Control plane authorized networks.
* Click Add authorized network.
* For Name, type the name for the network, use Corporate.
* For Network, type a CIDR range that you want to grant whitelisted access to your cluster master. As an example, you can use 192.168.1.0/24.
* Click Done.

### Create a cluster network policy

```bash
gcloud container clusters create $my_cluster --num-nodes 3 --enable-ip-alias --zone $my_zone --enable-network-policy
```
Note that this command adds the additional flag --enable-network-policy to the parameters you have used in previous labs. This flag allows this cluster to use cluster network policies.

```bash
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/GKE_Networks/

kubectl apply -f hello-allow-from-foo.yaml
```

+MORE

## LAB: Creating Services and Ingress Resources

https://googlecoursera.qwiklabs.com/focuses/19360955

### Create Pods and services to test DNS resolution

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1/GKE_Services

```yaml
apiVersion: v1
kind: Service
metadata:
  name: dns-demo
spec:
  selector:
    name: dns-demo
  clusterIP: None
  ports:
  - name: dns-demo
    port: 1234
    targetPort: 1234
---
apiVersion: v1
kind: Pod
metadata:
  name: dns-demo-1
  labels:
    name: dns-demo
spec:
  hostname: dns-demo-1
  subdomain: dns-demo
  containers:
  - name: nginx
    image: nginx
---
apiVersion: v1
kind: Pod
metadata:
  name: dns-demo-2
  labels:
    name: dns-demo
spec:
  hostname: dns-demo-2
  subdomain: dns-demo
  containers:
  - name: nginx
    image: nginx
```

```bash
kubectl exec -it dns-demo-1 -- /bin/bash
apt-get update
apt-get install -y iputils-ping
```

```bash
ping dns-demo.default.svc.cluster.local
```

***When you deploy applications, your application code runs inside a container in the cluster, and thus your code can access other services by using the FQDNs of those services from inside that cluster. This approach is simpler than using IP addresses or even Pod names, because those are more likely to change.***


.....

***Notice that the new LoadBalancer service lists the regional-loadbalancer reserved address as its external IP address. In GKE environments the external load balancer for the LoadBalancer service type is implemented using a Google Cloud load balancer and will take a few minutes to create. This external IP address makes the service accessible from outside the cluster.***


Why did it connect to V2 and not V1, while V1 still exists?

How do I connect to V1 after loadbalancing??

Answered in Ingress Section..

https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/ak8s/v1.1/GKE_Services/hello-ingress.yaml


## QUIZ: Google Kubernetes Engine Networking

Your Pod has been rescheduled and the IP address that was assigned to the Pod when it was originally scheduled is no longer accessible.  What is the reason for this?

* The new Pod has received a different IP address.

-------

You have updated your application and deployed a new Pod. What step can you take to ensure that you can access the Pod and and the Pod's application throughout the lifecycle of the Pod using a durable IP address?

* Deploy a Kubernetes Service with a selector that locates the application's Pods.

-------

During testing you cannot find the Google Cloud Load Balancer that should have been configured for your application. You check the manifest for the applicaton and notice that the application's front-end Service type is ClusterIP. How can you correct this?

* Define spec.type as LoadBalancer in the YAML manifest for the service and redeploy it.

-------

What change can an administrator make to achieve the lowest possible latency when using a Google Cloud load-balancer service to balance network traffic, minimizing double-hop traffic between nodes? Assume that container-native load balancing is not in use.

* Set the spec.type field to LoadBalancer in the YAML manifest. WRONG
* Set the externalTrafficPolicy field to local in the YAML manifest.

Review the Service Types and Load Balancers lesson.

-------

You are designing a GKE solution. One of your requirements is that network traffic load balancing should be directed to Pods directly, instead of balanced across nodes. What change can you make to your environment?

* Configure all external access for your application using Ingress resources rather than Services. WRONG
* Set the externalTrafficPolicy field to local in the YAML manifest for your external services. WRONG
* Configure or migrate your cluster to VPC-Native Mode and deploy a Container- native load balancer.

Review the Container-Native Load Balancing lesson.

-------

You need to apply a network policy to five Pods to block ingress traffic from other Pods. Each Pod has a label of app:demo-app. In your network policy manifest, you have specified the label app:demo-app in spec.podSelector. The policy is configured and when you list the Network Policies on your cluster you can see the policy listed but is not having any effect as you can still ping the Pods from other Pods in the cluster. What is the problem and what action can you take to correct this?

* Network policies are only applied when a Pod is started. Stop all of the Pods in your application and restart them in order to activate the network policy. WRONG
* You have not enabled network policies on the cluster. Enable network policies on the cluster, and reboot all of the nodes.

Review the Network Security lesson.
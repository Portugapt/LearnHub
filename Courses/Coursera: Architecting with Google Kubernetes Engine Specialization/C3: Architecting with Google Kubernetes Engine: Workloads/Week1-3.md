- [Persistent Data and Storage](#persistent-data-and-storage)
  - [emptyDir](#emptydir)
  - [ConfigMap](#configmap)
    - [Create keys](#create-keys)
    - [Use directory to config](#use-directory-to-config)
    - [Manifest](#manifest)
    - [Examples](#examples)
    - [Quiz](#quiz)
  - [Secret](#secret)
  - [downwardAPI](#downwardapi)
  - [Create an NFS volume](#create-an-nfs-volume)
  - [Persistent volumes](#persistent-volumes)
    - [The Abstraction of these volumes](#the-abstraction-of-these-volumes)
  - [Practice Quiz 1](#practice-quiz-1)
  - [StatefulSet](#statefulset)
  - [Lab1: Configuring Persistent Storage for Google Kubernetes Engine](#lab1-configuring-persistent-storage-for-google-kubernetes-engine)
    - [Create PVs and PVCs](#create-pvs-and-pvcs)
    - [Mount and verify Google Cloud persistent disk PVCs in Pods](#mount-and-verify-google-cloud-persistent-disk-pvcs-in-pods)
    - [Create StatefulSets with PVCs](#create-statefulsets-with-pvcs)
  - [Lab: Working with Google Kubernetes Engine Secrets and ConfigMaps](#lab-working-with-google-kubernetes-engine-secrets-and-configmaps)
  - [Final Quiz](#final-quiz)

# Persistent Data and Storage

![vol1](https://i.imgur.com/285Tjph.png)

![vol2](https://i.imgur.com/GmGDegX.png)

![vol3](https://i.imgur.com/iJiZCoE.png)

![vol4](https://i.imgur.com/hVNCpwB.png)

## emptyDir

An emptyDir volume is simply an empty directory that allows the containers within the pod to read and write to and from it. 

For short-term usage.

## ConfigMap

![configm5](https://i.imgur.com/V5C4SMc.png)

![config1](https://i.imgur.com/lfbYWQI.png)
Ephemeral.

The ConfigMap resource provides a way to inject application configuration data into pods from Kubernetes. The data stored in ConfigMap object can be referenced in a volume. 

E.g. in a webserver to setup parameters.

Save configuration files, command-line arguments  
![configm1](https://i.imgur.com/PtBl1e6.png)

### Create keys

![configm2](https://i.imgur.com/e4lN1FK.png)

### Use directory to config
![configm3](https://i.imgur.com/FsUBaBG.png)

### Manifest
![configm4](https://i.imgur.com/dKSVPbN.png)

### Examples
![configmex1](https://i.imgur.com/7Sc5SHp.png)

![configmex2](https://i.imgur.com/xrjufTM.png)

![configmex3](https://i.imgur.com/3utaf9U.png)

### Quiz

How frequently does the kubelet refresh the values of ConfigMaps mounted as volumes inside Pods?

- Roughly on the order of seconds or minutes

How frequently does the kubelet refresh the values of ConfigMaps stored in environment variables inside Pods?

- Never

## Secret

Ephemeral.

Pass sensitive information to a pod.
Back by in-memory file systems.  

## downwardAPI

Make downwardAPI data avaliable.
It's a way containers can learn about their pod environment. For example, suppose your containerized application needs to construct an identifier that's guaranteed to be unique in the cluster, wouldn't it be easier to base that identifier on the name of this pod since pod names are unique in the cluster too? The downwardAPI is how your application can fetch the name of the pod it's running on if you choose to make it available. 

## Create an NFS volume

![nfs1](https://i.imgur.com/72Gm2Do.png)

A volume section is added under the pod spec. The volume is named and fields are configured with the access details for an existing NFS share. This creates an NFS volume when the pod is created. In order to mark the volume to a container, the volume name and mount path must be specified under the volumeMounts field for the container.
![nfs2](https://i.imgur.com/3pKwihH.png)

The data volume is just mounted. The volume is created during the pod creation. After the volume is created, it's available to any container in the pod before the containers are brought online.
![nfs3](https://i.imgur.com/eqfqe5X.png)

## Persistent volumes

![pvols1](https://i.imgur.com/Lpr9FFF.png)

Separation of roles.  
Persistent volumes allows data to stay on failure.  
Pods talk with eachother more easily?  
dynamic reschedule components without loss  

![pvols2](https://i.imgur.com/sFuDIwO.png)

![pvols3](https://i.imgur.com/udcUHfd.png)

And the manifest should look like this (old way):  
![pvols4](https://i.imgur.com/t5a1bzI.png)

### The Abstraction of these volumes

![apv1](https://i.imgur.com/eUPKdyF.png)

A standard class of PV:  
![apv2](https://i.imgur.com/kVvOGeU.png)

An SSD version:  
![apv3](https://i.imgur.com/dOps3mS.png)

By the way don't confuse Kubernetes storage classes with storage classes that google cloud storage makes available. Although the features have the same name, they are unrelated because they come from different services and govern different features. Google cloud storage is object store for the Web, while Kubernetes storage classes are choices for how persistent volumes are bagged.

![apvwrite](https://i.imgur.com/Kxhu8Xz.png)

![apv4](https://i.imgur.com/lXE6ah0.png)
Persistent volumes can't be added to pod specifications directly, instead, you must use persistent volume claims in order for these persistent volume claims to claim the persistent volume, their storage class names and access modes must match.

And, to mount the PV, the manifest should look like this:  
![apvman](https://i.imgur.com/XOQtKVG.png)

What happens if there isn't an existing persistent volume to satisfy the persistent volume claim? 

If it cannot find an existing persistent volume, Kubernetes will try to provide a new one dynamically.  

![pvdynamic](https://i.imgur.com/dtyrzHX.png)

![pvregions](https://i.imgur.com/i7i3XFW.png)

## Practice Quiz 1

What happens if a Pod fails while it is using a persistent volume?

* The volumes are unmounted from the failing Pod, and they continue to exist with their last contents.

-----

True or false: Volumes allow containers within a Pod to share data.

* True

-----

What is the primary difference between Secrets and ConfigMaps?

* Secrets are intended for use with security-sensitive data, such as private keys, while ConfigMaps are intended for use with general-purpose configuration information.

-----

How can a Pod request persistent storage without specifying the details of how that storage is to be implemented?

* By using a PersistentVolumeClaim

## StatefulSet

https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

A StatefulSet object defines a desired state and its controller achieves it. 
Persistent Identity.

![ssets1](https://i.imgur.com/1v9EWqR.png)

If demo-0 fails after demo-1 is running and ready, but before the creation of demo-2, will not be launched until demo-0 is relaunched and becomes running and ready.
![demos1](https://i.imgur.com/AJ3Sl1a.png)

Updates happen in reverse order.
![demos2](https://i.imgur.com/smhx2bT.png)


![ssetexample](https://i.imgur.com/Grxn4yU.png)

A label selector is required
![ssetexample2](https://i.imgur.com/EzaKaSw.png)

![ssetex3](https://i.imgur.com/Uk6UHSD.png)

This manifest can be seen in the website.

How are the Pods that make up a StatefulSet distinguished from one another?

- By an ordinal index at the end of their names
  
How can I make a headless Service to bring together the Pods in a StatefulSet?

- By specifying None for the cluster IP in the Service definition

## Lab1: Configuring Persistent Storage for Google Kubernetes Engine

### Create PVs and PVCs

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1/Storage

Create cluster and run
```bash
kubectl apply -f pvc-demo.yaml
```

### Mount and verify Google Cloud persistent disk PVCs in Pods

Run  
```bash
kubectl apply -f pod-volume-demo.yaml
```

Access the pod   
`kubectl exec -it pvc-demo-pod -- sh`

Run
```bash
echo Test webpage in a persistent volume!>/var/www/html/index.html
chmod +x /var/www/html/index.html
```
And then
```bash
cat /var/www/html/index.html
```

Lets test the persistence

```bash
kubectl delete pod pvc-demo-pod
```

```bash
kubectl get persistentvolumeclaim
```
The PVC still exists.

Create the pod again  
`kubectl apply -f pod-volume-demo.yaml`  
And go inside, check if the message is there.

`kubectl exec -it pvc-demo-pod -- sh`  
`cat /var/www/html/index.html`

### Create StatefulSets with PVCs

```bash
kubectl apply -f statefulset-demo.yaml
```

Creates a bunch of statefulset volumes:  
`kubectl describe statefulset statefulset-demo`

```bash
kubectl get pvc
```  
The original hello-web-disk is still there and you can now see the individual PVCs that were created for each Pod in the new statefulset Pod.

```bash
kubectl describe pvc hello-web-disk-statefulset-demo-0
```
Events:
  Type    Reason                 Age    From                         Message
  ----    ------                 ----   ----                         -------
  Normal  ProvisioningSucceeded  3m56s  persistentvolume-controller  Successfully provisioned volume pvc-79122f74-432f-4721-8a13-dfc0f123d702 using kubernetes.io/gce-pd

## Lab: Working with Google Kubernetes Engine Secrets and ConfigMaps 

https://googlecoursera.qwiklabs.com/focuses/19367393

## Final Quiz

An application owner has created a Pod manifest using a PersistentVolumeClaim with a StorageClassName value of standard. What type of storage is used for this volume in a GKE Cluster?

- NFS Storage. WRONG
- Local volume on the node. WRONG
- Google Persistent Disk.

------

You have created a ConfigMap and want to make the data available to your application. Where should you configure the directory path parameters in the Pod manifest to allow your application to access the data as files?

- spec.containers.volumeMounts

------

You are creating a new PersistentVolume object, and the Volume is to be created using Google Cloud standard Persistent Disks. What property must you configure to set the read/write characteristics for the Volume to the correct setting?

- accessModes: [ReadWriteOnce]

------

A stateful set consists of four Pods that are named Demo-0, Demo-1, Demo-2 and Demo-3. The StatefulSet originally only had two replica Pods but this was recently increased to four replicas. An update is being rolled out to this StatefulSet using the RollingUpdate updateStrategy type. Which Pod will be the last member of the StatefulSet to be updated?

- Demo-0

------

A stateful set consists of four Pods that are named Demo-0, Demo-1, Demo-2 and Demo-3; with matching volumeClaims called Demo-0 to Demo-3 assigned by the StatefulSet. Demo-1 Pod has failed and the StatefulSet controller deploys a new Pod to replace it. What will the new Pod be called and what storage volume is attached to it?

- The new Pod will be called Demo-1 and will have the existing Demo-1 volume attached to it.

------

Which type of Kubernetes Secret should you use to pass credentials for an image repository so that Kubelet can pull private images on behalf of your Pods?

- A Docker Registry Secret
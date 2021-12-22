- [Access Control and Security in Kubernetes and GKE](#access-control-and-security-in-kubernetes-and-gke)
  - [Authentication and Authorization](#authentication-and-authorization)
    - [Quiz](#quiz)
  - [Cloud IAM](#cloud-iam)
    - [Roles](#roles)
    - [Quiz](#quiz-1)
  - [Role Based Access Control (RBAC)](#role-based-access-control-rbac)
    - [Define roles](#define-roles)
    - [Quiz](#quiz-2)
  - [Kubernetes Control Plane Security](#kubernetes-control-plane-security)
    - [Quiz](#quiz-3)
    - [Important reads](#important-reads)
  - [Pod Security](#pod-security)
    - [Apply Pod Security Policy](#apply-pod-security-policy)
  - [Lab: Securing Google Kubernetes Engine with Cloud IAM and Pod Security Policies](#lab-securing-google-kubernetes-engine-with-cloud-iam-and-pod-security-policies)
  - [Lab: Implementing Role-Based Access Control with Google Kubernetes Engine](#lab-implementing-role-based-access-control-with-google-kubernetes-engine)

# Access Control and Security in Kubernetes and GKE

![img1](https://i.ibb.co/51MLwZJ/image.png)

![img2](https://i.ibb.co/h9hgP4p/image.png)

## Authentication and Authorization

Kubernetes relies on external Identity Services.

![user1](https://i.ibb.co/YhpFYkQ/image.png)

Any Cloud Identity member can be configured as a normal user in GKE Kubernetes clusters. 

![user2](https://i.ibb.co/yn33jhN/image.png)

Kubernetes service accounts are accounts managed by Kubernetes. Kubernetes service accounts provide an identity for processes in a pod and are used to interact with the cluster.
And you use them when you want GCP resources to have an identity that's tied to an application or a virtual machine, not a human being.


![rbac](https://i.ibb.co/MRwTFcq/image.png)

OpenID Connect is a simple identity layer on top of the OAuth 2.0 Protocol. It Let's clients verify the identity of an end-user by currying an authorization server. The clients can also get basic profile information about the end user in an interoperable way.

![security1](https://i.ibb.co/tx6MFrL/image.png)

### Quiz

Which authentication method is enabled by default in GKE clusters of version 1.12 and later?

- OpenID Connect

Question 2

True or false: Both Cloud IAM and Kubernetes RBAC are relevant to managing GKE clusters.

- True

## Cloud IAM

![cloudiam1](https://i.ibb.co/VvWtXx1/image.png)

![organization](https://i.ibb.co/7QJNmWp/image.png)

Here is a key factor to keep in mind when you're designing your policies. There's no way to grant a permission at a higher level in the hierarchy and then take it away below. In general, the policies you apply at higher levels should grant very few permissions. And the policies you apply at lower levels should grant additional permissions to only those who need them.

### Roles

Basic roles:  

![basicroles](https://i.ibb.co/JqLGnK3/image.png)


GKE Predefined roles:  

![gkeroles](https://i.ibb.co/BwJgZ6m/image.png)

At project level.

And custom roles:  

![customroles](https://i.ibb.co/3s1J2DT/image.png)

### Quiz

True or false: It is possible to grant an IAM permission at a higher point in the Google Cloud resource hierarchy and revoke it at a lower point.  

- False

Use of which kind of Cloud IAM role may be incompatible with the principle of least privilege?

- Primitive

## Role Based Access Control (RBAC)

RBAC is a native Kubernetes security feature that provides you with fine grained tools to manage user account permissions. In GKE environments, RBAC extends Cloud IAM security, by offering control over Kubernetes resources within the cluster, supplementing the control provided directly by Cloud IAM, which allow you to control access of the GKE and cluster level.

![rbac1](https://i.ibb.co/YjyzhzN/image.png)

![rbac2](https://i.ibb.co/bHQhhtG/image.png)

Roles and RoleBindings. Roles connect API resources and verbs. RoleBindings connect Roles to subjects. Roles and RoleBindings can be applied at the cluster or namespace level.

![rbac3](https://i.ibb.co/CV7vXsy/image.png)

### Define roles

![rbac4](https://i.ibb.co/CJrQtKm/image.png)

![rbac5](https://i.ibb.co/kHyTchc/image.png)

![summaryrbac](https://i.ibb.co/G7RbN75/image.png)

### Quiz

Choose all the resources below that are namespace-scoped rather than cluster-scoped. 

- [X] Pods
- [X] StatefulSets
- [X] Deployments
- [ ] Secrets
- [ ] nodes
- [ ] PersistentVolumes

Question 2

True or false: Kubernetes RBAC offers both "allow" and "deny" rules.

- False

## Kubernetes Control Plane Security

![kcps1](https://i.imgur.com/MosrvvT.png)

![kcps2](https://i.imgur.com/sKidx4s.png)

![kcps3](https://i.imgur.com/2sgwuc5.png)

### Quiz

True or false: if one of your GKE clusters' TLS certificates are compromised, you must replace the certificates on all your GKE clusters.

- False

It's a good security practice to rotate your GKE cluster credentials frequently, to limit the value of any compromised keys. What is the tradeoff inherent in rotating your cluster credentials?

- During the rotation, your cluster's API endpoint is unavailable for a short while.

### Important reads 

Documentation on protecting cluster metadata

For further details on control plane security and protecting cluster metadata within Kubernetes please refer to the links below.

    Kubernetes control plane security:
    https://cloud.google.com/kubernetes-engine/docs/concepts/control-plane-security

    Protecting cluster metadata:
    https://cloud.google.com/kubernetes-engine/docs/how-to/protecting-cluster-metadata


## Pod Security

Security context

![ps1](https://i.imgur.com/Fnuo8iu.png)

Seccoom: Block system call I know the pod should not be legitimaly be making.

AppArmor: restrict individual programs actions

Grant some but not all privileges to a process.

Pod Security policies: A set of rules I can apply to a collective of pods.  
Reusable security context

![ps2](https://i.imgur.com/9kEBKxW.png)

The manifest of a pod security policy:  
![ps3](https://i.imgur.com/Iu5Itx7.png)

### Apply Pod Security Policy

![psp1](https://i.imgur.com/R69MlKO.png)

After you defined Pod security policy, you need to authorize it. Otherwise, it will prevent any pods from being created. You can authorize a policy by using Kubernetes role-based access control.

![psp2](https://i.imgur.com/ku7cnMA.png)

![psp3](https://i.imgur.com/aSQtXK1.png)

Without a PodSecurityPolicy controller, pod security policies mean nothing. 
You need to both define the policies and to enable the PodSecurityPolicy controller. ***Be careful here, the order matters.*** If you enable PodSecurityPolicy controller before defining any policies, you've just commanded that nothing is allowed to be deployed.


![pathsecure](https://i.imgur.com/DdhsUOv.png)

## Lab: Securing Google Kubernetes Engine with Cloud IAM and Pod Security Policies

https://googlecoursera.qwiklabs.com/focuses/19371652

```bash
export USERNAME_1_EMAIL=$(gcloud info --format='value(config.account)')

However, before you can create a role, the account you use to create the role must already have the permissions granted in the role being assigned. For cluster administrators this can be easily accomplished by creating the necessary RoleBinding to grant your own user account the cluster-admin role. The Username 1 account has project owner rights and this automatically makes this user a cluster administrator.

kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USERNAME_1_EMAIL
```

Caution!

The PodSecurityPolicy controller must be enabled to affect the admission control of new Pods in the cluster.

If you do not define and authorize policies prior to enabling the PodSecurityPolicy controller, some accounts will not be able to deploy or run Pods on the cluster.

## Lab: Implementing Role-Based Access Control with Google Kubernetes Engine

https://googlecoursera.qwiklabs.com/focuses/19372599

https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/ak8s/v1.1/RBAC

https://kubernetes.io/docs/reference/access-authn-authz/rbac/

## Quiz

Question 1

What type of account is used by processes in containers in a Pod to communicate with the kube-apiserver running on the Kubernetes cluster control plane?

- A Kubernetes Service Account

-------

You want to implement account controls that will allow you to grant junior admin users the ability to view details about production clusters and applications, and to be able to fully manage test and lab resources inside your GKE cluster environments. Which account control mechanism will provide you with the level of granular control that is required for this type of user?

- Kubernetes RBAC

-------

Question 3

Which service can be used to synchronize enterprise user accounts to your Google Cloud infrastructure, so that you can define Cloud IAM policies for them?

- Migrate your enterprise user accounts to a Cloud Identity or G Suite organization. WRONG
- Add your enterprise LDAP or Active Directory domain to Cloud Identity and Access Management. WRONG
- Use Google Cloud Directory Sync (GCDS) to synchronize the accounts between your enterprise directory and Cloud IAM.

-------

Question 4

When granting users the permissions to access and perform actions on Google Cloud resources using Cloud IAM, what type of Google Cloud object needs to be created in order to grant roles to member accounts?

- A Cloud IAM permission WRONG
- A Cloud IAM Policy

-------

Your organization is creating a new support team that will need to be able to view your Kubernetes Engine clusters and also access a number of Operations features. You want to keep these users tightly controlled and need to make sure they only have the minimum level of access necessary to perform their jobs. What type of Cloud IAM role will you be using to assign these users the permissions they need?

- A Custom role

-------

You have configured a new role using Kubernetes RBAC. You have supplied the action verbs you want for that role, and have added the users you require as subjects to the role. What is the next step you need to take in order to allow the users to perform those actions against the correct objects in your environment?

- Bind the RBAC role to a Kubernetes service account that has the permissions necessary to manage the objects required by the role. WRONG
- Bind the RBAC role to the Kubernetes objects these users need to manage.

-------

What security features can you control using Pod securityContexts? Choose all responses that are correct (2 correct responses).

- [ ] Configure network access control lists, controlling which network endpoints can access, or be accessed by, the Pod.
- [X] Limit access to some Linux capabilities, for example to grant certain privileges to a process, but not all root user privileges.
- [ ] Limit access to Google Cloud services and resources, for example to prevent users of the Pod from accessing Cloud Storage objects.
- [X] Enable AppArmor, which uses security profiles to restrict individual programs actions.
- [ ] Configure audit logging to redirect all Pod logs to an external webhook backend for persistent event auditing.

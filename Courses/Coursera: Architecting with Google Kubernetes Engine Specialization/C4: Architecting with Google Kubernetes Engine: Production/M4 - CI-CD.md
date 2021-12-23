# CI/CD for Google Kubernetes Engine

What is CI/CD and why is it important?  

![cicd1](https://i.imgur.com/EMNU2SJ.png)

![cicd2](https://i.imgur.com/NYouVNM.png)

![cicd3](https://i.imgur.com/H6kdrkl.png)

## The pipelines

To implement CI CD correctly, you need to construct a pipeline. A pipeline is a process that takes in a version of your applications code base and performs all of the steps necessary to release it to production. Pipelines can be triggered manually, or they can be triggered automatically when changes are pushed to the code base. They are generally composed of separate stages. Most commonly these four. The first stage is built. In this stage the code base is checked out to a specific version and artifacts. For example, Docker container images are built. After the build stage the next stages deploy in this stage, the artifacts are deployed into a test environment that replicates the production environment. After the application has been deployed. It is moved to test stage, here the application is tested in multiple ways to ensure application quality. The most common types of tests are eunice, functional, integration, vulnerability and performance. Finally if the application passes all the test it can move to Approve stage, in this stage developers can manually determine whether a pipeline should proceed to the production environment.

![cicdpipe](https://i.imgur.com/ayvSOdi.png)

![cicdauto](https://i.imgur.com/8vodDvz.png)

## CI/CD Tools

![exampletools](https://i.imgur.com/0cbswY4.png)

### Cloud Build

![cb1](https://i.imgur.com/rsdvN5d.png)

![cb2](https://i.imgur.com/MbUBNcx.png)

## Lab: CI/CD for Google Kubernetes Engine using Cloud Build

https://googlecoursera.qwiklabs.com/focuses/19381187

```bash
gcloud artifacts repositories create my-repository \
  --repository-format=docker \
  --location=us-central1
```

Create repos in Cloud Build (after creating a workspace, and logging into Git)  
```bash
gcloud source repos create hello-cloudbuild-app
gcloud source repos create hello-cloudbuild-env
```

https://github.com/GoogleCloudPlatform/gke-gitops-tutorial-cloudbuild

    
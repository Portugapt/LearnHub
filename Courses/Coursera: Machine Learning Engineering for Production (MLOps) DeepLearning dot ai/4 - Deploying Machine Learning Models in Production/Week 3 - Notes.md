# Model Management and Delivery

- [Model Management and Delivery](#model-management-and-delivery)
  - [Experiment Tracking](#experiment-tracking)
  - [Tools for Experiment Tracking](#tools-for-experiment-tracking)
  - [Introduction to MLOps](#introduction-to-mlops)
  - [MLOps level 0](#mlops-level-0)
  - [MLOps level 1 and 2](#mlops-level-1-and-2)
  - [Developing Components for an Orchestrated Workflow](#developing-components-for-an-orchestrated-workflow)
    - [Components in TFX](#components-in-tfx)
      - [Python](#python)
      - [Container-based](#container-based)
      - [Custom component](#custom-component)
  - [Managing Model Versions](#managing-model-versions)
  - [Continuous Delivery](#continuous-delivery)
  - [Progressive Delivery](#progressive-delivery)
  - [Lab 1](#lab-1)
  - [Lab 2](#lab-2)
  - [References](#references)
  - [Quiz 1 - ML Experiments Management and Workflow Automation](#quiz-1---ml-experiments-management-and-workflow-automation)
    - [Is debugging in ML different from debugging in software engineering?](#is-debugging-in-ml-different-from-debugging-in-software-engineering)
    - [Which of the following tools allow you to track experiments with notebooks? (Select all that apply)](#which-of-the-following-tools-allow-you-to-track-experiments-with-notebooks-select-all-that-apply)
    - [Which of the following are some good tools for Data Versioning?](#which-of-the-following-are-some-good-tools-for-data-versioning)
    - [True Or False: Concerns such as cost, performance, stability, scalability, maintainability, and schedule are much more important to data scientists than software engineers.](#true-or-false-concerns-such-as-cost-performance-stability-scalability-maintainability-and-schedule-are-much-more-important-to-data-scientists-than-software-engineers)
  - [Quiz 2 - MLOps Methodology](#quiz-2---mlops-methodology)
    - [What determines the maturity of the MLOps process?](#what-determines-the-maturity-of-the-mlops-process)
    - [True Or False: At the basic level of maturity, or level 0, tracking or logging are required to detect model performance degradation and other model behavioral drifts.](#true-or-false-at-the-basic-level-of-maturity-or-level-0-tracking-or-logging-are-required-to-detect-model-performance-degradation-and-other-model-behavioral-drifts)
    - [What steps do you need to introduce into the ML pipeline to move towards MLOps maturity level one? (Select all that apply)](#what-steps-do-you-need-to-introduce-into-the-ml-pipeline-to-move-towards-mlops-maturity-level-one-select-all-that-apply)
    - [In case of an interruption, what key component of the pipeline allows you to resume execution seamlessly?](#in-case-of-an-interruption-what-key-component-of-the-pipeline-allows-you-to-resume-execution-seamlessly)
  - [Quiz 3 - Model Management and Deployment Infrastructure](#quiz-3---model-management-and-deployment-infrastructure)
    - [When does the minor version number increase in the MAJOR.MINOR.PIPELINE approach of model versioning?](#when-does-the-minor-version-number-increase-in-the-majorminorpipeline-approach-of-model-versioning)
    - [Which well known product uses pipeline execution versioning?](#which-well-known-product-uses-pipeline-execution-versioning)
    - [What are some non-standard ML Unit Testing Considerations? (Select all that apply)](#what-are-some-non-standard-ml-unit-testing-considerations-select-all-that-apply)
    - [Which of the following is true about the comparison between canary and blue-green deployment?](#which-of-the-following-is-true-about-the-comparison-between-canary-and-blue-green-deployment)

## Experiment Tracking

![ET1](https://i.imgur.com/pSe2vvB.png)

It's important to keep track of experiments, since machine learning is more of a  experimental science than rigorous. It's important to keep track of changes both in models and data over time. 

![ET2](https://i.imgur.com/bJ3MPwl.png)

![ET3](https://i.imgur.com/pZPn2lU.png)

![ET4](https://i.imgur.com/Mighz1G.png)

in more advanced and distributed workflow, code repositories and versioning with commits are powerful and widely available tools for managing large projects, including experiments. In these cases, you probably want to keep experiments separate if you're using a shared monorepo with your team so that your commits don't version the rest of the team's repo.

![etc1](https://i.imgur.com/eBGYGdY.png)

![etc2](https://i.imgur.com/KQ3mmny.png)

## Tools for Experiment Tracking

![TET1](https://i.imgur.com/eJAy09q.png)

If you're adding new data or purging old data or cleaning up your data, it will change the results of your experiments. So just like when you make changes in your code or your model or your hyper parameters, you need to track versions of your data. You might also change your feature vector as you experiment to add delete or change features and that needs to be versioned. So if you're going to be able to track, understand, compare and duplicate your experimental results you need to version your data.

![TET2](https://i.imgur.com/5IanDpy.png)

![TET3](https://i.imgur.com/fmKOxCz.png)

![TET4](https://i.imgur.com/mqmRB0j.png)

Tagging each experiment and adding your notes will help both you and your team and help avoid having to rerun experiments more than once.

![TET5](https://i.imgur.com/pXIPSoA.png)

![TET6](https://i.imgur.com/9iM0K11.png)

Tools like that are a big help and a huge improvement over spreadsheets and notes. However you can take your machine learning project to the next level with creative iterations. In every project, there is a phase where a business specification is created that usually includes a schedule, budget and the goals of the project. The goals are usually a set of KPIs, business metrics or if you are incredibly lucky, actual machine learning metrics. You and your team should choose what you think might be achievable as business goals that align with the project and start by defining a baseline approach. Implement your baseline and evaluate to get a first set of metrics. Often you'll learn a lot from those first baseline results. They may be close to meeting your goals, which tells you that this is likely to be an easy problem. Or your results may be far off so far off that you'll start to wonder about the strength of the predictive signal in your data and start considering more complex modelling approaches.

## Introduction to MLOps

![MLOPS1](https://i.imgur.com/ogBZ69H.png)

![MLOPS2](https://i.imgur.com/a53jJT2.png)

![MLOPS3](https://i.imgur.com/GPXVyQx.png)

![MLOPS4](https://i.imgur.com/YJepLMf.png)

![MLOPS5](https://i.imgur.com/JCcYspk.png)

![MLOPS6](https://i.imgur.com/mRxpjlO.png)

is that where ML is today in today's perspective for many teams, it can take months to deploy their models to production once they've trained them. In some cases being that slow to market means missing opportunities or deploying models that are already decayed. Moreover, traditional data science projects lack tracking and then there are problems like manual tracking and models not being reproducible and data lacking provenance and a general lack of good tools and processes for collaboration between different teams. And once models do get deployed to production, there's often no monitoring for them. DevOps and is an engineering discipline which focuses on developing and managing software systems. It was developed over decades of experience and learning in the software development industry. Some of the potential benefits that it offers include reducing development cycles, increasing deployment velocity and ensuring dependable releases of high quality software. Like DevOps, MLOps is an ML engineering culture and practice that aims at unifying ML system development or dev and ML system operation or ops. Unlike DevOps, ML systems present unique challenges to core DeVOps principles like continuous integration which for ML means that you not only just test and validate code and components but also do the same for data schemas and models. Continuous delivery on the other hand, isn't just about deploying a single piece of software or service, but as a system more precisely, an ML pipeline that deploys a model to a prediction service automatically. As ML emerges from research disciplines like software engineering, DevOps and ML need to converge forming MLOps. So with that comes the need to employ a novel DevOps automation techniques dedicated for training and monitoring machine learning models. That includes continuous training, a new property that is unique to ML systems, which automatically re trains models for both testing and serving. And once you have models in production, it's important to catch errors and monitor inference data and performance metrics with continuous monitoring.

![MLOPS7](https://i.imgur.com/UHl6HGM.png)

![MLOPS8](https://i.imgur.com/pQHX4ZU.png)

Now, let's consider the major phases in the life cycle of an ML solution. Usually a data scientist or an ML engineer. Yeah, and you start by shaping data and developing an ML model and continue by experimenting until you get results which meet your goals. After that, you typically go ahead and set up pipelines for continuous training unless you already use the pipeline structure for your experimenting in model development, which I would encourage you to consider. Then you turn to model deployment, which involves more of the operations and infrastructure aspects of your production environment and processes. And then continuous monitoring of your model systems and data from your incoming requests. The data from those incoming requests will become the basis for further experimentation and continuous training. So, as you go from continuous training to model deployment, the tasks evolve into something that traditionally a DevOps engineer would be responsible for. That means that you need a DevOps engineer who understands ML deployment and monitoring. And now let's move on to a new practice for collaboration and communication between data scientists and operation professionals which is known as MLOps. MLOps provides capabilities that will help you build, deploy and manage machine learning models that are critical for ensuring the integrity of business processes. It also provides a consistent and reliable means to move models from development to production by managing the ML Lifecycle. Models generally need to be iterated and versioned. To deal with an emerging set of requirements, the models change based on further training or real world data that's closer to the current reality. MLOps also includes creating versions of models as needed and maintaining model version history. And as the real world and its data continuously change, it's critical that you manage model decay. With MLOps you can ensure that by monitoring and managing the model results continuously, you can make sure that accuracy, performance and other objectives and key requirements are acceptable. MLOps platforms also generally provide capabilities to audit compliance, access control, governance testing and validation and change and access logs. The logged information can include details related to access control like who is publishing models, why modifications are done and when models were deployed or used in production. You also need to secure your models from both attacks and unauthorized access. MLOps solutions can provide some functionality to protect models from being corrupted by infected data, being made on unavailable by denial of service contracts or being inappropriately accessed by unauthorized users. Once you've made sure your models are secure, trustable and good to go, it's often a good practice to establish a platform where they can be easily discovered by your team.

## MLOps level 0

![mlopsl01](https://i.imgur.com/xq6gU4N.png)

Fundamentally, the level of automation of the data, modeling, deployment, and maintenance systems determines the maturity of the MLOps process.
Ideally, this means automating the complete ML workflow with as little manual intervention as possible. Triggers for automated model training and deployment can be calendar events, messaging or monitoring events, as well as changes in data, model training code and application code or detected model decay.

![l0ml2](https://i.imgur.com/NBzvRoF.png)

Includes having less frequent releases, aka no CI/CD. Often Unit Testing is also ignored.
Also includes lack of model performance monitoring

![l0ml3](https://i.imgur.com/ALDotDP.png)

## MLOps level 1 and 2

![l1ml1](https://i.imgur.com/4Hdppul.png)

![l1ml2](https://i.imgur.com/Ed3rppv.png)

let's talk about why data validation is necessary before model training to decide whether you should retrain the model, or stop the execution of the pipeline. This decision is automatically made only if the data is deemed valid. For example, data schema skews are considered anomalies in the input data, which means that the downstream pipeline steps including data processing and model training, receives data that doesn't comply with the expected schema. In this case, you should stop the pipeline and raise a notification so that the team can investigate. The team might release a fix or an update to the pipeline to handle these changes in the schema.

Model validation is another step, which runs after you successfully train the model given the new data. Here, you evaluate and validate the model before it's promoted to production. This offline model validation step may involve first producing evaluation metric values, using the train model on a test data set to assess the model's predictive quality. Then, the next step would be to compare the evaluation metric values produced by your newly trained model to the current model. For example, the current production model or a baseline model or any other model which meets your business requirements. Here, you make sure that the new model performs better than the current model before promoting it to production.

![l1ml4](https://i.imgur.com/ng19zkd.png)

An optional additional component for level one MLOps is a feature store. A feature store is a centralized repository where you standardize the definition, storage, and access of features for training and serving. Ideally, a feature store will provide an API for both high throughput batch serving and low latency, real time serving for the feature values, and support both training and serving workloads. A feature store helps you in many ways. First of all, it lets you discover and reuse available feature sets instead of recreating the same or similar feature sets, avoiding having similar features that have different definitions by maintaining features and their related metadata.

This approach makes sure that the features used for training are the same ones used during serving. For example, when it comes to experimentation, data scientists can get an offline extract from the feature store to run their experiments. For continuous training, the automated training pipeline can fetch a batch of the up to date feature values of the data set. For online prediction, the prediction service can fetch feature values such as customer demographic features, product features, and current session aggregation features.

![l1ml6](https://i.imgur.com/ALPzwQP.png)

Another key component is the metadata store, where information about each execution of the pipeline is recorded in order to help with data and artifact lineage, reproducibility, and comparisons. It also helps you debug errors and anomalies. Each time you execute the pipeline, the metadata store tracks information such as the pipeline and component versions which were executed, the start and end time and date, and how long the pipeline took to complete each of the steps, and the input and output artifacts from each step, and more.

![l2ml1](https://i.imgur.com/hmQvrqh.png)

Speculative way of MLOps level 2

![together](https://i.imgur.com/r0QGtLl.png)

## Developing Components for an Orchestrated Workflow

![pipe1](https://i.imgur.com/WzERy1C.png)

![pipe2](https://i.imgur.com/lvpg9OU.png)

![pipe3](https://i.imgur.com/1HmEdWR.png)

A python function based component, those are the easiest to build and they're easier than container based components are fully custom components. They only require Python function for the executor with a decorator and annotations. On the other hand, container based components provide the flexibility to integrate code written in any language into your pipeline, assuming that you can execute that code in a docker container. To create a container based component, you create a component definition that is very similar to a Docker file and cause a wrapper function to instantiate it. Next we'll learn how you can make use of each of the custom component types.

### Components in TFX

#### Python

![CTFX1](https://i.imgur.com/f8A6uv1.png)

#### Container-based

![CTFX2](https://i.imgur.com/eC2XsgR.png)

![CTFX3](https://i.imgur.com/yf0J9d1.png)

#### Custom component

![CTFX4](https://i.imgur.com/5htjxFI.png)

![CTFX5](https://i.imgur.com/Jxj9c4n.png)

![CTF6](https://i.imgur.com/lCpl3y7.png)

![CTFX7](https://i.imgur.com/lCpl3y7.png)

![CTFX8](https://i.imgur.com/JrnxGFP.png)

![CTFX9](https://i.imgur.com/QJnTb9V.png)

![CTFX10](https://i.imgur.com/U5OnuLA.png)

![CTFX11](https://i.imgur.com/TKJJldw.png)

## Managing Model Versions

![MV1](https://i.imgur.com/DUDnSaJ.png)

![MV2](https://i.imgur.com/kGZCEPJ.png)

![MV3](https://i.imgur.com/PPGKaPl.png)

![MV4](https://i.imgur.com/bksIUl7.png)

![MV5](https://i.imgur.com/cH50WxK.png)

![MV6](https://i.imgur.com/OWwGVjx.png)

![MV7](https://i.imgur.com/MHhSSq4.png)

![MV8](https://i.imgur.com/mLUIQQi.png)

![MV9](https://i.imgur.com/0jbMcIq.png)

## Continuous Delivery

![CI](https://i.imgur.com/U0w4yE4.png)

Dependent on the unit test suite.

![CD](https://i.imgur.com/DzmWm9g.png)

![cicdinfra](https://i.imgur.com/QUwEbvD.png)

![UNIT1](https://i.imgur.com/K8YTl7b.png)

![UNIT2](https://i.imgur.com/CNZGuir.png)

![UNIT3](https://i.imgur.com/bZIM3K5.png)

![UNIT](https://i.imgur.com/dysMEvc.png)

![TFXINFRA](https://i.imgur.com/Q6cPHdD.png)

Infrastructure validation acts as an early warning layer before pushing a model into production to avoid issues with models that might not run or might perform badly when actually serving requests in production. It focuses on the compatibility between the model server binary and the model which is about to be deployed. 

In a TFX pipeline the infraValidator component takes the model launches a sandbox model server with the model and sees if it can successfully be loaded and optionally queried. If the model behaves as expected, then it is referred to as blessed and considered ready to be deployed.

## Progressive Delivery

![PD1](https://i.imgur.com/auzhnfU.png)

![PD2](https://i.imgur.com/dOMESxA.png)

![PD3](https://i.imgur.com/aYh9IaM.png)

![PD4](https://i.imgur.com/6cOmMKm.png)

One simple form of live experimentation is A/B testing. In A/B testing, you have at least two different models or perhaps n different models and you compare the business results between them to select the model that gives the best business performance.

![PD5](https://i.imgur.com/uc28Hxq.png)

![PD6](https://i.imgur.com/mSAmj28.png)

![PD7](https://i.imgur.com/mniPaMf.png)

An even more advanced approach is contextual bandit. The contextual bandit algorithm is an extension of the multi-arm bandit approach where you also factor in the customer's environment or other context of the request when choosing a bandit. The context affects how reward is associated with each bandit, so as contexts change, the model should learn to adapt its bandit choice. For example, consider recommending clothing choices to people in different climates. A customer in a hot climate will have a very different context than a customer in a cold climate. Not only do you want to find the maximum reward, you also want to reduce the reward loss when you're exploring different bandits. When judging the performance of a model, the metric that measures the reward loss is called regret which is the difference between the cumulative reward from the optimal policy and the model's cumulative sum of rewards over time. The lower the regret, the better the model.

## Lab 1

https://googlecoursera.qwiklabs.com/focuses/19801925?parent=lti_session

## Lab 2

https://github.com/GoogleCloudPlatform/mlops-on-gcp
https://github.com/GoogleCloudPlatform/mlops-on-gcp/tree/master/workshops/mlep-qwiklabs/tfserving-canary-gke

https://googlecoursera.qwiklabs.com/focuses/19803697?parent=lti_session

```bask

cd
SRC_REPO=https://github.com/GoogleCloudPlatform/mlops-on-gcp
kpt pkg get $SRC_REPO/workshops/mlep-qwiklabs/tfserving-canary-gke tfserving-canary
cd tfserving-canary

gcloud config set compute/zone us-central1-f
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_NAME=cluster-1

gcloud beta container clusters create $CLUSTER_NAME \
  --project=$PROJECT_ID \
  --addons=Istio \
  --istio-config=auth=MTLS_PERMISSIVE \
  --cluster-version=latest \
  --machine-type=n1-standard-4 \
  --num-nodes=3

gcloud container clusters get-credentials $CLUSTER_NAME

kubectl get pods -n istio-system


kubectl label namespace default istio-injection=enabled
```

```bash
export MODEL_BUCKET=${PROJECT_ID}-bucket
gsutil mb gs://${MODEL_BUCKET}

gsutil cp -r gs://workshop-datasets/models/resnet_101 gs://${MODEL_BUCKET}
gsutil cp -r gs://workshop-datasets/models/resnet_50 gs://${MODEL_BUCKET}

kubectl apply -f tf-serving/configmap-resnet50.yaml
## To the model bucket.

kubectl apply -f tf-serving/deployment-resnet50.yaml

kubectl apply -f tf-serving/service.yaml

kubectl apply -f tf-serving/gateway.yaml

kubectl apply -f tf-serving/virtualservice.yaml
## Has to do with Istio.
```

Set the ingress IP and port:
Set the gateway URL
```bash
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo $GATEWAY_URL 
```

Canary release

```bash
kubectl apply -f tf-serving/destinationrule.yaml

kubectl apply -f tf-serving/virtualservice-weight-100.yaml

kubectl apply -f tf-serving/virtualservice-focused-routing.yaml
```

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata: # kpt-merge: /image-classifier
  name: image-classifier
spec:
  hosts:
  - "*"
  gateways:
  - image-classifier-gateway
  http:
  - route:
    - destination:
        host: image-classifier
        subset: resnet50
        port:
          number: 8501
      weight: 100
    - destination:
        host: image-classifier
        subset: resnet101
        port:
          number: 8501
      weight: 0
```

## References

https://codefresh.io/docs/docs/ci-cd-guides/progressive-delivery/

https://neptune.ai/blog/mlops

https://github.com/visenger/awesome-mlops

https://12factor.net/

https://cloud.google.com/architecture/architecture-for-mlops-using-tfx-kubeflow-pipelines-and-cloud-build

## Quiz 1 - ML Experiments Management and Workflow Automation

### Is debugging in ML different from debugging in software engineering?
1 / 1 point

* Yes, debugging in ML is fundamentally different from debugging in software engineering.
Correct

!!! note Absolutely! ML debugging is often about a model not converging or not generalizing instead of some functional error like a segfault.

### Which of the following tools allow you to track experiments with notebooks? (Select all that apply)
1 / 1 point

* Nbdime
Correct

!!! note Keep it up! This tool enables diffing and merging of Jupyter Notebooks.

* Nbconvert
Correct

!!! note Great job! Nbconvert can be used to extract just the Python from a notebook.

* Jupytext
Correct

!!! note ou’ve figured it out! Jupytext converts and synchronizes pairs of notebooks with a matching Python file.

### Which of the following are some good tools for Data Versioning?
1 / 1 point

* Delta Lake
Correct

!!! note You did it! Delta Lake runs on top of your existing data lake and provides data versioning, including rollbacks and full historical audit trails.

* Pachyderm
Correct

!!! note Way to go! This tool lets you continuously update data in the master branch while experimenting with specific data in a separate branch.

* Neptune
Correct

!!! note Nice job! Neptune includes data versioning, experiment tracking, and a model registry.

### True Or False: Concerns such as cost, performance, stability, scalability, maintainability, and schedule are much more important to data scientists than software engineers.
1 / 1 point

* False
Correct

!!! note Yes! Software engineers identify themselves strongly with customer satisfaction and recognize infrastructure needs being as crucial as optimizing metrics. As a result, they strongly focus on quality, testing, and detecting and mitigating errors.

## Quiz 2 - MLOps Methodology

### What determines the maturity of the MLOps process?
1 / 1 point

* The level of automation of ML pipelines.
Correct

!!! note Great job! Fundamentally, the level of automation of the Data Collection, Modeling, Deployment, and Maintenance systems determines the maturity of the MLOps process.

### True Or False: At the basic level of maturity, or level 0, tracking or logging are required to detect model performance degradation and other model behavioral drifts.
1 / 1 point

* False
Correct

!!! note Exactly! Level 0 is concerned only with deploying the trained model as a prediction service (for example, a microservice with a REST API). This manual, data-scientist-driven process doesn’t track predictions and might be sufficient when models are rarely changed or retrained.

### What steps do you need to introduce into the ML pipeline to move towards MLOps maturity level one? (Select all that apply)
1 / 1 point

* Automated Data Validation
Correct

!!! note That's right! Automated data validation is necessary to decide whether your model should be retrained or the execution of the pipeline must stop. This decision is automatically made only if the data is deemed valid.

* Automated Model Validation
Correct

!!! note Well done! Model Validation makes sure that the new model performs better than the current one before promoting it to production. Also, Model Validation ensures that model performance is consistent on various segments of the data.

### In case of an interruption, what key component of the pipeline allows you to resume execution seamlessly?
1 / 1 point

* Metadata Store
Correct

!!! note Nailed it! The metadata store tracks each pipeline execution, so you can rely on pointers to the artifacts produced at each step, like the location of prepared data, validation anomalies, or computed statistics, to resume execution in case of an interruption.

## Quiz 3 - Model Management and Deployment Infrastructure

### When does the minor version number increase in the MAJOR.MINOR.PIPELINE approach of model versioning?
1 / 1 point

* When we’ve improved the model's output.
Correct

!!! note Spot on! The minor version will increment when we believe that we've improved or enhanced the model's output.

### Which well known product uses pipeline execution versioning?
1 / 1 point

* TensorFlow Extended
Correct

!!! note That's right! TFX uses pipeline execution versioning. In this style, a new version is defined with each successfully run training pipeline. Models will be versioned regardless of changes to model architecture, input, or output.

### What are some non-standard ML Unit Testing Considerations? (Select all that apply)
1 / 1 point

* Data Coverage
Correct

!!! note Way to go! Ideally, your mocks should occupy roughly the same region of your feature space as the actual data would, but much more sparsely, of course.

* Mocking
Correct

!!! note Nice job! Designing mocks of datasets is essential for ML unit testing. They should cover your edge and corner cases, requiring you to think about your features and domain.

* Code Coverage
Correct

!!! note Well done! If you've created good mocks and good tests, you should have good code coverage. Using the available code coverage libraries, you can test and track that you're not missing unit tests for any part of the code.

### Which of the following is true about the comparison between canary and blue-green deployment?
1 / 1 point

* Canary is cheaper than a blue-green deployment because it does not require two production environments.
Correct

!!! note Exactly! Canary deployments allow organizations to test in production with real users and cases and compare different service versions side by side.
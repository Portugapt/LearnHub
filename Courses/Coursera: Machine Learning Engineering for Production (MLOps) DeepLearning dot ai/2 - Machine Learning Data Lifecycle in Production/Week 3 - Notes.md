# Data Journey

- [Data Journey](#data-journey)
  - [Data lineage, provinance and versioning](#data-lineage-provinance-and-versioning)
  - [TFX Metadata](#tfx-metadata)
    - [Inside](#inside)
  - [In Code](#in-code)
  - [Schemas](#schemas)
  - [Feature Stores](#feature-stores)
  - [Data Warehouses](#data-warehouses)
  - [Data lake](#data-lake)
  - [Lab 1 Notes](#lab-1-notes)
  - [Review Schemas](#review-schemas)
  - [Quiz 1 - Data Journey](#quiz-1---data-journey)
    - [Machine learning pipelines for production have become prominent in several industries. They introduce complexity to the ML lifecycle due to the large amount of data, tools, and workflows involved. If data and models are not tracked properly during the life cycle, it becomes infeasible to recreate an ML model from scratch or to explain to stakeholders how it was created. What can be done to prevent these shortcomings?](#machine-learning-pipelines-for-production-have-become-prominent-in-several-industries-they-introduce-complexity-to-the-ml-lifecycle-due-to-the-large-amount-of-data-tools-and-workflows-involved-if-data-and-models-are-not-tracked-properly-during-the-life-cycle-it-becomes-infeasible-to-recreate-an-ml-model-from-scratch-or-to-explain-to-stakeholders-how-it-was-created-what-can-be-done-to-prevent-these-shortcomings)
    - [ML Metadata (MLMD) is a library for recording and retrieving metadata associated with ML production pipelines among other applications. What is the definition of attribution in this library?](#ml-metadata-mlmd-is-a-library-for-recording-and-retrieving-metadata-associated-with-ml-production-pipelines-among-other-applications-what-is-the-definition-of-attribution-in-this-library)
    - [Every run of a production ML pipeline generates metadata about its components, their executions (e.g. training runs), and the resulting artifacts (e.g. trained models). ML metadata (MLMD) registers this information in a database called the Metadata Store. The MetaDataStore object receives a connection configuration that corresponds to the storage backend used. Which of the following configurations will you use for fast experimentation and local runs?](#every-run-of-a-production-ml-pipeline-generates-metadata-about-its-components-their-executions-eg-training-runs-and-the-resulting-artifacts-eg-trained-models-ml-metadata-mlmd-registers-this-information-in-a-database-called-the-metadata-store-the-metadatastore-object-receives-a-connection-configuration-that-corresponds-to-the-storage-backend-used-which-of-the-following-configurations-will-you-use-for-fast-experimentation-and-local-runs)
  - [Quiz 3 - Enterprise Data Storage](#quiz-3---enterprise-data-storage)
    - [As data evolves during its life cycle, which of the following factors should ML pipelines address to operate properly?(check all that apply).](#as-data-evolves-during-its-life-cycle-which-of-the-following-factors-should-ml-pipelines-address-to-operate-properlycheck-all-that-apply)
    - [Many modeling problems use identical or similar features, and there is substantial value in enabling teams to share features between their own projects and for teams in different organizations to share features with each other. Which of the following storage solutions is deliberately designed to address these user cases?](#many-modeling-problems-use-identical-or-similar-features-and-there-is-substantial-value-in-enabling-teams-to-share-features-between-their-own-projects-and-for-teams-in-different-organizations-to-share-features-with-each-other-which-of-the-following-storage-solutions-is-deliberately-designed-to-address-these-user-cases)
    - [Which are the main advantages of using a cloud-based data warehouse ?(check all that apply)](#which-are-the-main-advantages-of-using-a-cloud-based-data-warehouse-check-all-that-apply)
    - [About data lakes it’s only true that:](#about-data-lakes-its-only-true-that)

## Data lineage, provinance and versioning

![keys1](https://i.imgur.com/wBtaH4q.png)

![dl1](https://i.imgur.com/hX07tjz.png)

![dl2](https://i.imgur.com/aNV4Ytd.png)

![dl3](https://i.imgur.com/Od6xM84.png)

![dl4](https://i.imgur.com/t2KuiCY.png)

![dl5](https://i.imgur.com/93KX4c5.png)

![dl6](https://i.imgur.com/T9VGrwV.png)

Personal data is highly sensitive, so tracking the origins and changes along the pipeline are key for compliance. Data lineage is a great way for businesses and organizations to quickly determined how the Data has been used and which Transformations were performed as the Data moved through the pipeline.

![dl7](https://i.imgur.com/Q49XlZm.png)

![ob1](https://i.imgur.com/A9zG0Tz.png)

## TFX Metadata

![tf1](https://i.imgur.com/wUmESIa.png)

![tf2](https://i.imgur.com/Mwvk0rl.png)

First, there are artifacts. An artifact is an elementary unit of data that gets fed into the ML metadata store and as the data is consumed as input or generated as output of each component. Next there are executions. Each execution is a record of any component run during the ML pipeline workflow, along with its associated runtime parameters. Any artifact or execution will be associated with only one type of component. Artifacts and executions can be clustered together for each type of component separately. This grouping is referred to as the context. A context may hold the metadata of the projects being run, experiments being conducted, details about pipelines, etc. Each of these units can hold additional data describing it in more detail using properties. Next there are types, previously, you've seen several types of units that get stored inside the ML metadata. Each type includes the properties of that type. Lastly, we have relationships. Relationships store the various units getting generated or consumed when interacting with other units. For example, an event is the record of a relationship between an artifact and an execution. So, ML metadata stores a wide range of information about the results of the components and execution runs of a pipeline. It stores artifacts and it stores the executions of each component in the pipeline. It also stores the lineage information for each artifact that is generated. All of this information is represented in metadata objects and this metadata is stored in a back end storage solution. Let's take a look at the architecture of ML metadata or MLMD. On the top are the various components present in any ML pipeline. All of these components are individually connected to a centralized metadata store of ML metadata, so that each component can independently access the metadata at any stage of the pipeline.

![tf3](https://i.imgur.com/Sa0f3QF.png)

### Inside

![tf4](https://i.imgur.com/6Wq0HOR.png)

![tf5](https://i.imgur.com/PVvZgKA.png)

## In Code

![key2](https://i.imgur.com/OHJ4Ogn.png)

![inc1](https://i.imgur.com/FRV8Bbm.png)

![inc2](https://i.imgur.com/OIpAluW.png)

![inc3](https://i.imgur.com/Em1SGWn.png)

![inc4](https://i.imgur.com/4VK8phw.png)

![inc5](https://i.imgur.com/O2Gc9uF.png)

![inc6](https://i.imgur.com/o3iUEP6.png)

## Schemas

![key3](https://i.imgur.com/bkxixWD.png)

![schemas1](https://i.imgur.com/gasv19s.png)

![schemas2](https://i.imgur.com/2Okyj8D.png)

Changing data often results in a new schema being generated. However, there are some special use cases. Imagine that even before you assess the dataset, you have an idea or information about the expected range of values for your features. The initial dataset that you've received is covering only a small range of those values. In that case, it makes sense to adjust or create your schema to reflect the expected range of values for your features. A similar situation may exist for the expected values of categorical features. Besides that, your schema can help you find problems or anomalies in your dataset, such as missing required values or values of the wrong type. All these factors have to be considered when you're designing the schema of your ML pipeline. As data keeps evolving, there are some requirements which must be met in production deployments.

![schemas3](https://i.imgur.com/Nu3ERSi.png)

![schemas4](https://i.imgur.com/TXE9yIn.png)

![schemas5](https://i.imgur.com/IMMJ3ed.png)

![schemas6](https://i.imgur.com/Cjvs4wR.png)

![schemas7](https://i.imgur.com/90IMbCA.png)

## Feature Stores

![fs3](https://i.imgur.com/ZjW4zqj.png)

![fs1](https://i.imgur.com/QU2VBPL.png)

![fs2](https://i.imgur.com/ctmJgYR.png)

![fs4](https://i.imgur.com/qFXtKir.png)

For historical features in a badger environment, it's also usually straightforward. However, when you're training your model, you need to make sure that you only include data that will be available at the time that a serving request is made. Including data that is only available at some time after a serving request is referred to as time travel. And many feature stores include safeguards to avoid that.

![fs6](https://i.imgur.com/YcHJz6G.png)

## Data Warehouses

![dw1](https://i.imgur.com/qSM5Zw1.png)

![dw2](https://i.imgur.com/ZJQtG5g.png)

![dw3](https://i.imgur.com/umHNUaZ.png)

![dw4](https://i.imgur.com/I2zeSxt.png)

## Data lake

![dl1](https://i.imgur.com/PwOGpm7.png)

![dl2](https://i.imgur.com/vAOPN5J.png)

![dl3](https://i.imgur.com/dgZNcVF.png)

## Lab 1 Notes

![l1](https://i.imgur.com/Cp2Srnx.png)

The green box in the middle shows the data model followed by ML Metadata. The [official documentation](https://www.tensorflow.org/tfx/guide/mlmd#data_model) describe each of these and we'll show it here as well for easy reference:

* `ArtifactType` describes an artifact's type and its properties that are stored in the metadata store. You can register these types on-the-fly with the metadata store in code, or you can load them in the store from a serialized format. Once you register a type, its definition is available throughout the lifetime of the store.
* An `Artifact` describes a specific instance of an ArtifactType, and its properties that are written to the metadata store.
* An `ExecutionType` describes a type of component or step in a workflow, and its runtime parameters.
* An `Execution` is a record of a component run or a step in an ML workflow and the runtime parameters. An execution can be thought of as an instance of an ExecutionType. Executions are recorded when you run an ML pipeline or step.
* An `Event` is a record of the relationship between artifacts and executions. When an execution happens, events record every artifact that was used by the execution, and every artifact that was produced. These records allow for lineage tracking throughout a workflow. By looking at all events, MLMD knows what executions happened and what artifacts were created as a result. MLMD can then recurse back from any artifact to all of its upstream inputs.
* A `ContextType` describes a type of conceptual group of artifacts and executions in a workflow, and its structural properties. For example: projects, pipeline runs, experiments, owners etc.
* A `Context` is an instance of a ContextType. It captures the shared information within the group. For example: project name, changelist commit id, experiment annotations etc. It has a user-defined unique name within its ContextType.
* An `Attribution` is a record of the relationship between artifacts and contexts.
* An `Association` is a record of the relationship between executions and contexts.

----


An event defines a relationship between artifacts and executions. You will generate the input event relationship for dataset artifact and data validation execution units. The list of event types are shown [here](https://github.com/google/ml-metadata/blob/master/ml_metadata/proto/metadata_store.proto#L211) and the event is recorded with the `put_events()` function.

```python
# Declare the input event
input_event = metadata_store_pb2.Event()
input_event.artifact_id = data_artifact_id
input_event.execution_id = dv_execution_id
input_event.type = metadata_store_pb2.Event.DECLARED_INPUT

# Submit input event to the Metadata Store
store.put_events([input_event])

print('Input event:\n', input_event)
```

## Review Schemas

## Quiz 1 - Data Journey

### Machine learning pipelines for production have become prominent in several industries. They introduce complexity to the ML lifecycle due to the large amount of data, tools, and workflows involved. If data and models are not tracked properly during the life cycle, it becomes infeasible to recreate an ML model from scratch or to explain to stakeholders how it was created. What can be done to prevent these shortcomings?
1 / 1 point

* Establish data and model provenance tracking mechanisms.

Correct

That’s right! Provenance will track the chain of artifacts and transformations at play in a given pipeline.

### ML Metadata (MLMD) is a library for recording and retrieving metadata associated with ML production pipelines among other applications. What is the definition of attribution in this library? 
1 / 1 point


* Is a record of the relationship between artifacts and contexts.

Correct

Just right! Please check the ML metadata documentation for more information.

### Every run of a production ML pipeline generates metadata about its components, their executions (e.g. training runs), and the resulting artifacts (e.g. trained models). ML metadata (MLMD) registers this information in a database called the Metadata Store. The MetaDataStore object receives a connection configuration that corresponds to the storage backend used. Which of the following configurations will you use for fast experimentation and local runs?
1 / 1 point


* Fake Database
Correct

Good job! This provides a fast in-memory DB that can be easily destroyed after experimentation.

## Quiz 3 - Enterprise Data Storage

### As data evolves during its life cycle, which of the following factors should ML pipelines address to operate properly?(check all that apply).
0.8 / 1 point

* Account for scalable solutions.
Correct

Spot on. Production traffic will vary from day to day and thus your pipeline must scale accordingly. 

* Account for anomaly detection.
Correct

Way to go! For example data errors must be handled in the same way as code bugs.

* Provide resilient mechanisms for disruptions.
Correct

Keep it up!. For example ML pipelines should incorporate resilient mechanisms to deal with inconsistent data.

### Many modeling problems use identical or similar features, and there is substantial value in enabling teams to share features between their own projects and for teams in different organizations to share features with each other. Which of the following storage solutions is deliberately designed to address these user cases?
1 / 1 point

* Feature Store
Correct

Correct! Feast is an example of an open source feature store.

### Which are the main advantages of using a cloud-based data warehouse ?(check all that apply)
1 / 1 point

* They are cost efficient
Correct

Perfect! Otherwise all the software and hardware costs will be handled by your organization. 

* Provides easy on-demand scalable solution
Correct

Nice going! Cloud solutions are really flexible for scaling up.

### About data lakes it’s only true that:
1 / 1 point

* Can handle both structured and unstructured data.
Correct

That’s right! Data lakes are really flexible in the type of data they can handle.
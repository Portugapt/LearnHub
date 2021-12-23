# Use GC Storage Services

If I want to focus more on the code than managing a storage,, it's better to pass this kind of work to Google Storage Services, like GS or BQ

![keepsecure](https://i.imgur.com/YpUiPEC.png)

![flowofcredentials](https://i.imgur.com/U8zfWx1.png)

What is the best way to use Google Cloud managed services from an application running in GKE?

- Create a new service account, give it a Cloud IAM role with least privilege, store its credential in a Kubernetes secret, and use the credential in API calls to the service.

## Lab: Using Cloud SQL with Google Kubernetes Engine

https://googlecoursera.qwiklabs.com/focuses/19381177

To create a Secret for your MySQL credentials, enter the following in the Cloud Shell.
```bash
kubectl create secret generic sql-credentials \
   --from-literal=username=sqluser\
   --from-literal=password=sqlpassword
```

## Quiz

**Q1**  

You want to reduce the management overheads associated with using a containerized MySQL server in your application. Which Google managed storage service can you use as a direct replacement?

- Cloud SQL

-----

**Q2**  

You are deploying an application running inside a Pod in a GKE cluster that needs to access a Google Cloud managed storage service in a secure and controlled manner. What step must you take in order to allow the application to access the service?

- The application must be provided with the credentials for a Google IAM account with the permissions required to access the Google Cloud service.

-----

**Q3**  

You are designing a solution for a new application and need to set out the guidelines for the accounts that will be used by the application to access managed Google Cloud services. Which of the following approaches follows the Google recommended practice for such accounts?

- Create a separate Google Cloud Service Account for each application and assign permissions to those accounts.

-----

**Q4**  

You are configuring applications that need access to Google managed storage services. The applications will be deployed to your GKE clusters. How should you provide the credentials to the applications so that they are protected?

- Create Kubernetes Secrets containing the account credential files and present those to the containers as environment variables or Secret Volumes.

-----

**Q5**  

You are considering options for your business continuity and data protection plans and have identified a number of systems that need to be archived periodically for regulatory compliance. These archives must be kept for up to 5 years and will need to be audited quarterly. Apart from the quarterly audit, there is no expectation that they will need to be accessed routinely. What Google Storage solution best matches these requirements?

- Cloud Storage - Nearline

-----

**Q6**  

Question 6

Which Google managed storage solution should you use for an online multiplayer game that needs to be able to propagate a consistent global game state across a massive number of concurrent sessions?

- Datastore
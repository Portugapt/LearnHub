# Recommending Products Using Cloud SQL and Spark 

## Instructions 1

SQL -> Create instance -> MySQL -> name:rentals  
note root password.

answers:
3 tables
Ratings, Accomodation, Recommendation.

View instance information. Point out interesting things

## Instructions 2

Go to Cloud Shell

```gcloud sql connect rentals --user=root --quiet```

answers:
Empty

## Instructions 3

COpy paste in shells.

## Instructions 4

SQL -> rentals -> Import


us-central1
us-central1-f

Create Cluster

Name: us-central1 
Zone:  us-central1-f 
Total worker nodes: 2

```
echo "Authorizing Cloud Dataproc to connect with Cloud SQL"
CLUSTER=rentals
CLOUDSQL=rentals
ZONE=us-central1-f
NWORKERS=2

machines="$CLUSTER-m"
for w in `seq 0 $(($NWORKERS - 1))`; do
   machines="$machines $CLUSTER-w-$w"
done

echo "Machines to authorize: $machines in $ZONE ... finding their IP addresses"
ips=""
for machine in $machines; do
    IP_ADDRESS=$(gcloud compute instances describe $machine --zone=$ZONE --format='value(networkInterfaces.accessConfigs[].natIP)' | sed "s/\['//g" | sed "s/'\]//g" )/32
    echo "IP address of $machine is $IP_ADDRESS"
    if [ -z  $ips ]; then
       ips=$IP_ADDRESS
    else
       ips="$ips,$IP_ADDRESS"
    fi
done

echo "Authorizing [$ips] to access cloudsql=$CLOUDSQL"
gcloud sql instances patch $CLOUDSQL --authorized-networks $ips
```

SQL address: 35.184.149.238

Conn name: qwiklabs-gcp-03-e0a351dec65e:us-central1:rentals
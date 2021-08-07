# Streaming Data Processing: Streaming Data Pipelines into Bigtable 

Objectives

In this lab, you will perform the following tasks:

* Launch Dataflow pipeline to read from Pub/Sub and write into Bigtable.

* Open an HBase shell to query the Bigtable database.


## Preparation

```bash
ls /training

git clone https://github.com/GoogleCloudPlatform/training-data-analyst

source /training/project_env.sh


cd ~/training-data-analyst/courses/streaming/process/sandiego
./install_quickstart.sh
```

## Simulate traffic sensor data into Pub/Sub

```bash
/training/sensor_magic.sh
```

On a new Shell:

```bash
source /training/project_env.sh
```

## Launch Dataflow Pipeline

Check out the code
```bash
cd ~/training-data-analyst/courses/streaming/process/sandiego

nano run_oncloud.sh
```

Run the command
```bash
cd ~/training-data-analyst/courses/streaming/process/sandiego

./create_cbt.sh
```

```bash
cd ~/training-data-analyst/courses/streaming/process/sandiego

./run_oncloud.sh $DEVSHELL_PROJECT_ID $BUCKET CurrentConditions --bigtable
```

## Query BigTable Data

```bash
cd ~/training-data-analyst/courses/streaming/process/sandiego/quickstart

./quickstart.sh
```

A HBase shell prompt should open


```HBase
scan 'current_conditions', {'LIMIT' => 2}
```

```HBase
scan 'current_conditions', {'LIMIT' => 10, STARTROW => '15#S#1', ENDROW => '15#S#999', COLUMN => 'lane:speed'}
```




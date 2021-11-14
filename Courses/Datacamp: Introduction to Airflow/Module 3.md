# Airflow Sensors

![](https://i.imgur.com/QJZA19q.png)

![](https://i.imgur.com/2aDOmtz.png)

`airflow.sensors.base_sensor_operator`

arguments:
* mode 
  * mode = 'poke'
  * mode = 'reschedule'
* poke_interval
* timeout
* other normal arguments

![](https://i.imgur.com/qwMqvnF.png)

## File Sensor

`airflow.contrib.sensors`

![](https://i.imgur.com/1zQIvVM.png)

## Other sensors available

![](https://i.imgur.com/riYZpvO.png)


## Exercise

![](https://i.imgur.com/AX6mXTU.png)


# Airflow Executers

![](https://i.imgur.com/Z0Fjm45.png)

![](https://i.imgur.com/mFo9rzR.png)

```bash
cat airflow/airflow.cfg | grep "executor = "
```

## SequentialExecuter

![](https://i.imgur.com/DN92wbu.png)

## LocalExecuter

![](https://i.imgur.com/U9KOYsz.png)

## CeleryExecuter

![](https://i.imgur.com/kbrXROS.png)


# Common issues (Troubleshooting)

![](https://i.imgur.com/y1KKuc3.png)

![](https://i.imgur.com/XzRsElU.png)

Or syntax errors.

> fixed a multi-layered issue for why the DAG would not load. Remember that sometimes having no apparent error does not necessarily mean everything is working as expected. It is common for there to be more than one simultaneous problem with loading workflows, even if the issues appear simple at first. Always try to consider the problems that could appear, and that there might be more than one as it will simplify your usage of Airflow.

# SLAs and reporting in Airflow

SERVICE LEVEL AGREEMENT

![](https://i.imgur.com/sJ4kP5H.png)

![](https://i.imgur.com/G94a2pQ.png)

```python
task1 = BashOperator(task_id = 'sla_task',
                    bash_command='runcode.sh',
                    sla = timedelta(seconds = 30),
                    dag=dag)
```
or
```python
default_args = {
    'sla' : timedelta(minutes=20),
    'start_date': datetime(2020,2,20)
    }
dag == DAG('sla_dag', default_args = default_args)
```

Example

```python
# Import the timedelta object
from datetime import timedelta, datetime

# Create the dictionary entry
default_args = {
  'start_date': datetime(2020, 2, 20),
  'sla': timedelta(minutes = 30)
}

# Add to the DAG
test_dag = DAG('test_workflow', default_args=default_args, schedule_interval='@None')
###################
# Import the timedelta object
from datetime import timedelta

test_dag = DAG('test_workflow', start_date=datetime(2020,2,20), schedule_interval='@None')

# Create the task with the SLA
task1 = BashOperator(task_id='first_task',
                     sla=timedelta(hours=3),
                     bash_command='initialize_data.sh',
                     dag=test_dag)
```

# Exercice - Defining a task

```python
# Define the email task
email_report = EmailOperator(
        task_id='email_report',
        to='airflow@datacamp.com',
        subject='Airflow Monthly Report',
        html_content="""Attached is your monthly workflow report - please refer to it for more detail""",
        files=['monthly_report.pdf'],
        dag=report_dag
)

# Set the email task to run after the report is generated
email_report << generate_report
```


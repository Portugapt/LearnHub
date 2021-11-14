# Working with templates

![](https://i.imgur.com/iFG7zhf.png)

So, basically a function of Operations? To loop over.

![](https://i.imgur.com/g3cTA67.png)

This example is problematic if we have a hundred files to read from.

![](https://i.imgur.com/HFGQYS6.png)

![](https://i.imgur.com/7UIIGA2.png)

Okey, it's more suscint and debuggable.

But how is it useful?

## Exercise 1

```python
from airflow.models import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime

default_args = {
  'start_date': datetime(2020, 4, 15),
}

cleandata_dag = DAG('cleandata',
                    default_args=default_args,
                    schedule_interval='@daily')

# Modify the templated command to handle a
# second argument called filename.
templated_command = """
  bash cleandata.sh {{ ds_nodash }} {{  params.filename  }}
"""

# Modify clean_task to pass the new argument
clean_task = BashOperator(task_id='cleandata_task',
                          bash_command=templated_command,
                          params={'filename': 'salesdata.txt'},
                          dag=cleandata_dag)

# Create a new BashOperator clean_task2
clean_task2 = BashOperator(task_id='cleandata_task2',
                           bash_command=templated_command,
                           params={'filename': 'supportdata.txt'},
                           dag=cleandata_dag)
                           
# Set the operator dependencies
clean_task >> clean_task2

```

# Jinja

![](https://i.imgur.com/2NHCRFe.png)


# Variables and macros

https://airflow.apache.org/docs/apache-airflow/stable/templates-ref.html

![](https://i.imgur.com/YJVR47e.png)

# Exercise 2

```python
from airflow.models import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime

filelist = [f'file{x}.txt' for x in range(30)]

default_args = {
  'start_date': datetime(2020, 4, 15),
}

cleandata_dag = DAG('cleandata',
                    default_args=default_args,
                    schedule_interval='@daily')

# Modify the template to handle multiple files in a 
# single run.
templated_command = """
  <% for filename in params.filenames %>
  bash cleandata.sh {{ ds_nodash }} {{ filename }};
  <% endfor %>
"""

# Modify clean_task to use the templated command
clean_task = BashOperator(task_id='cleandata_task',
                          bash_command=templated_command,
                          params={'filenames': filelist},
                          dag=cleandata_dag)
``` 

# Branching

## BranchPythonOperator

![](https://i.imgur.com/9FqqlFj.png)

## Example

![](https://i.imgur.com/799r1oJ.png)

![](https://i.imgur.com/nmJqT2p.png)

I find it confusing how this code pipelines to one or the other branch.

Shouldn't the function that splits have some way to say which pipeline the code flows to?

Answer: You return the name of the task_id you want to execute.


Python code example

```python
# Create a function to determine if years are different
def year_check(**kwargs):
    current_year = int(kwargs['ds_nodash'][0:4])
    previous_year = int(kwargs['prev_ds_nodash'][0:4])
    if current_year == previous_year:
        return 'current_year_task'
    else:
        return 'new_year_task'

# Define the BranchPythonOperator
branch_task = BranchPythonOperator(task_id='branch_task', dag=branch_dag,
                                   python_callable=year_check, provide_context=True)
# Define the dependencies
branch_dag >> current_year_task
branch_dag >> new_year_task
```

# Creating a production pipeline

![](https://i.imgur.com/AnUB8EW.png)

# Final Exercise

```python
from airflow.models import DAG
from airflow.contrib.sensors.file_sensor import FileSensor

# Import the needed operators
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash_operator import BashOperator
from datetime import date, datetime

def process_data(**context):
  file = open('/home/repl/workspace/processed_data.tmp', 'w')
  file.write(f'Data processed on {date.today()}')
  file.close()

    
dag = DAG(dag_id='etl_update', default_args={'start_date': datetime(2020,4,1)})

sensor = FileSensor(task_id='sense_file', 
                    filepath='/home/repl/workspace/startprocess.txt',
                    poke_interval=5,
                    timeout=15,
                    dag=dag)

bash_task = BashOperator(task_id='cleanup_tempfiles', 
                         bash_command='rm -f /home/repl/*.tmp',
                         dag=dag)

python_task = PythonOperator(task_id='run_processing', 
                             python_callable=process_data,
                             dag=dag)

sensor >> bash_task >> python_task
```

```bash
airflow test etl_update sense_file -1
```

Creating a production pipeline #2

Continuing on your last workflow, you'd like to add some additional functionality, specifically adding some SLAs to the code and modifying the sensor components.

Refer to the source code of the DAG to determine if anything extra needs to be added. The default_args dictionary has been defined for you, though it may require further modification.


* Add an SLA of 90 minutes to the DAG.
* Update the FileSensor object to check for files every 45 seconds.
* Modify the python_task to send Airflow variables to the callable. Note that the callable is configured to accept the variables using the provide_context argument.


```python
from airflow.models import DAG
from airflow.contrib.sensors.file_sensor import FileSensor
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from dags.process import process_data
from datetime import timedelta, datetime

# Update the default arguments and apply them to the DAG
default_args = {
  'start_date': datetime(2019,1,1),
  'sla' : timedelta(minutes=90)
}

dag = DAG(dag_id='etl_update', default_args=default_args)

sensor = FileSensor(task_id='sense_file', 
                    filepath='/home/repl/workspace/startprocess.txt',
                    poke_interval = 45,
                    dag=dag)

bash_task = BashOperator(task_id='cleanup_tempfiles', 
                         bash_command='rm -f /home/repl/*.tmp',
                         dag=dag)

python_task = PythonOperator(task_id='run_processing', 
                             python_callable=process_data,
                             provide_context = True,
                             dag=dag)

sensor >> bash_task >> python_task
```

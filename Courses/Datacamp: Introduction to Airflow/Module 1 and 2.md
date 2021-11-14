- [What is a workflow?](#what-is-a-workflow)
- [What is a DAG?](#what-is-a-dag)
  - [Creating DAGs](#creating-dags)
- [Run a webserver](#run-a-webserver)
- [Operators](#operators)
  - [Bash Operator](#bash-operator)
    - [Example code](#example-code)
  - [PythonOperator](#pythonoperator)
    - [Callable functions within the dag](#callable-functions-within-the-dag)
  - [EmailOperator](#emailoperator)
- [Tasks](#tasks)
  - [Examples](#examples)
- [Scheduling (CRON and Presets)](#scheduling-cron-and-presets)
  - [Gotcha](#gotcha)
  - [Exercise](#exercise)

# What is a workflow?

![](https://i.imgur.com/NP0swyj.png)

![](https://i.imgur.com/WartJTN.png)

![](https://i.imgur.com/vMgpzSQ.png)


# What is a DAG?

![](https://i.imgur.com/4hmVqTi.png)

![](https://i.imgur.com/8yBI8qu.png)

![](https://i.imgur.com/2eGDUqv.png)

On Python, it's possible to identify the DAG by it's var. name, but on shell, only by the DAG id.  
Every DAG pipeline needs an ID and a start date.
![](https://i.imgur.com/Zb6UOCE.png)


## Creating DAGs

![](https://i.imgur.com/zKZmJLZ.png)

![](https://i.imgur.com/l86Fhnu.png)

```python
# Import the DAG object
from airflow.models import DAG

# Define the default_args dictionary
default_args = {
  'owner': 'dsmith',
  'start_date': datetime(2020, 1, 14),
  'retries': 2
}

# Instantiate the DAG object
etl_dag = DAG('example_etl', default_args=default_args)
```

# Run a webserver

In the terminal  
```bash
airflow webserver -p XXXX
```
where XXXX is the port we want to start the server at.

Sometimes the defaults for Airflow aren't exactly what you'd like to use. Using the built in tools to configure the setup to your specifications is a very common function of a data engineer.

# Operators

![](https://i.imgur.com/thdriiB.png)

## Bash Operator
![](https://i.imgur.com/x4GKihn.png)

### Example code

The Airflow DAG `analytics_dag` is already defined for you and has the appropriate configurations in place.
```python
# Import the BashOperator
from airflow.operators.bash_operator import BashOperator

# Define the BashOperator 
cleanup = BashOperator(
    task_id='cleanup_task',
    # Define the bash_command
    bash_command='cleanup.sh',
    # Add the task to the dag
    dag=analytics_dag
)
```

Created my first operator to run a predefined Bash script. This is a common method to migrate from standalone scripts to an Airflow based workflow.

More examples

```python
# Define a second operator to run the `consolidate_data.sh` script
consolidate = BashOperator(
    task_id='consolidate_task',
    bash_command='consolidate_data.sh',
    dag=analytics_dag)

# Define a final operator to execute the `push_data.sh` script
push_data = BashOperator(
    task_id='pushdata_task',
    bash_command='push_data.sh',
    dag=analytics_dag)
```

## PythonOperator

![](https://i.imgur.com/DLHMieP.png)

### Callable functions within the dag

![](https://i.imgur.com/Kpwo6DP.png)

```python
def pull_file(URL, savepath):
    r = requests.get(URL)
    with open(savepath, 'wb') as f:
        f.write(r.content)   
    # Use the print method for logging
    print(f"File pulled from {URL} and saved to {savepath}")

from airflow.operators.python_operator import PythonOperator

# Create the task
pull_file_task = PythonOperator(
    task_id='pull_file',
    # Add the callable
    python_callable=pull_file,
    # Define the arguments
    op_kwargs={'URL':'http://dataserver/sales.json', 'savepath':'latestsales.json'},
    dag=process_sales_dag
)
```

Another example

```python
# Add another Python task
parse_file_task = PythonOperator(
    task_id='parse_file',
    # Set the function to call
    python_callable=parse_file,
    # Add the arguments
    op_kwargs={'inputfile':'latestsales.json', 'outputfile':'parsedfile.json'},
    # Add the DAG
    dag=process_sales_dag
)
```

## EmailOperator

An example
```python
# Import the Operator
from airflow.operators.email_operator import EmailOperator

# Define the task
email_manager_task = EmailOperator(
    task_id='email_manager',
    to='manager@datacamp.com',
    subject='Latest sales JSON',
    html_content='Attached is the latest sales JSON file as requested.',
    files='parsedfile.json',
    dag=process_sales_dag
)

# Set the order of tasks
pull_file_task >> parse_file_task >> email_manager_task
```

# Tasks

![](https://i.imgur.com/alkS6IR.png)

![](https://i.imgur.com/7i96cg3.png)

![](https://i.imgur.com/JiEfj5k.png)

## Examples

```python
# Define a new pull_sales task
pull_sales = BashOperator(
    task_id='pullsales_task',
    bash_command='wget https://salestracking/latestinfo?json',
    dag=analytics_dag
)

# Set pull_sales to run prior to cleanup
pull_sales >> cleanup

# Configure consolidate to run after cleanup
cleanup >> consolidate

# Set push_data to run last
consolidate >> push_data
```

# Scheduling (CRON and Presets)

![](https://i.imgur.com/8oa2qle.png)

![](https://i.imgur.com/gsKiWvd.png)

![](https://i.imgur.com/1hHIpGS.png)

![](https://i.imgur.com/ZMZmo3T.png)

![](https://i.imgur.com/G2E1d2A.png)


```python
# Update the scheduling arguments as defined
default_args = {
  'owner': 'Engineering',
  'start_date': datetime(day=1, month=11, year=2019),
  'email': ['airflowresults@datacamp.com'],
  'email_on_failure': False,
  'email_on_retry': False,
  'retries': 3,
  'retry_delay': timedelta(minutes=20)
}

dag = DAG('update_dataflows', default_args=default_args, schedule_interval='30 12 * * 3')
```

## Gotcha

![](https://i.imgur.com/1uzKm0v.png)

## Exercise

![](https://i.imgur.com/xUwbXtI.png)



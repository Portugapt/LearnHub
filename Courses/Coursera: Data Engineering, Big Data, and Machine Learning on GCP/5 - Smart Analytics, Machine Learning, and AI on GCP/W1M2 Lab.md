# BigQuery in Jupyter Labs on AI Platform 

In this lab, you learn to perform the following tasks:

* Instantiate a Jupyter notebook on AI Platform.

* Execute a BigQuery query from within a Jupyter notebook and process the output using Pandas.


------

Start a JupyterLab Notebook Instance

AI Platform -> Notebooks

Create Python3 Instance


Open the Instance and create a new notebook.

--- 
```jupyter
!pip install google-cloud-bigquery==1.25.0 --use-feature=2020-resolver
```

```jupyter
%%bigquery df
SELECT
  departure_delay,
  COUNT(1) AS num_flights,
  APPROX_QUANTILES(arrival_delay, 10) AS arrival_delay_deciles
FROM
  `bigquery-samples.airline_ontime_data.flights`
GROUP BY
  departure_delay
HAVING
  num_flights > 100
ORDER BY
  departure_delay ASC
```

This will save a dataframe with the name `df` in memory. This df comes from the query provided.
It makes use of the `%%bigquery` magic function in jupyter.

Now lets make a plot with pandas

```python
import pandas as pd

percentiles = df['arrival_delay_deciles'].apply(pd.Series)
percentiles.rename(columns = lambda x : '{0}%'.format(x*10), inplace=True)
percentiles.head()
```

```python
df = pd.concat([df['departure_delay'], percentiles], axis=1)
df.head()
```

Drop extremes in 0% and 100% fields.
Make the plot.
```python
df.drop(labels=['0%', '100%'], axis=1, inplace=True)
df.plot(x='departure_delay', xlim=(-30,50), ylim=(-50,50));
```

End.


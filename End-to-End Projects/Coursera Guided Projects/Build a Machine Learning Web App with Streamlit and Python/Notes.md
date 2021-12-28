# Build a Machine Learning Web App with Streamlit and Python

https://docs.streamlit.io/library/api-reference
https://docs.streamlit.io/library/components/components-api


In this course, we are going to focus on three learning objectives:

1. Build interactive web applications with Streamlit and Python

2. Train Logistic Regression, Random Forest, and Support Vector Classifiers using scikit-learn

3. Plot evaluation metrics for binary classification algorithms

Structure:  
Task 1: Project Overview and Demo  
Task 2: Turn Simple Python Scripts into Web Apps  
Task 3: Load the Mushrooms Data Set  
Task 4: Creating Training and Test Sets  
Task 5: Plot Evaluation Metrics  
Task 6: Training a Support Vector Classifier  
Task 7: Training a Support Vector Classifier (Part 2)  
Task 8: Train a Logistic Regression Classifier  
Task 9: Training a Random Forest   

## Code

```python
import streamlit as st
```

```python
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import plot_confusion_matrix, plot_roc_curve, plot_precision_recall_curve
from sklearn.metrics import precision_score, recall_score 
```


```python
st.title('Binary Classification Web App') # Add a title
st.sidebar.title('Binary Classification Web App')
```


The decorator `@st.cache(persist=True)`  
Unless the name, input or arguments change, the function will be cached.
```python
    @st.cache(persist = True)
    def load_data():
        data = pd.read_csv('/home/rhyme/Desktop/Project/mushrooms.csv')
        label = LabelEncoder()

        for col in data.columns:
            data[col] = label.fit_transform(data[col])
        return data
```

To select/show plots, here's a snippet:  
```python
def plot_metrics(metrics_list):
    if 'Confusion Matrix' in metrics_list:
        st.subheader('Confusion Matrix') #A subheader, for information purposes
        plot_confusion_matrix(model, x_test, y_test, display_labels = ['edible','poisonous']) # Construct the CM with scikit. 
        st.pyplot() # Display the plot in streamlit
```

`st.sidebar.selectbox()` is a drop-down list method.  
Example:  
```python
classifier = st.sidebar.selectbox("Classifier",
                    ("SVM", "LR", "RF"))
```  
With the result:  
![dd](https://i.imgur.com/kdnkHaA.png)

```python
st.sidebar.number_input("Display name", min_val, max_val, steps=increment_steps, key="Unique identifier of this button") # Number input in streamlit

st.sidebar.radio("kernel", ('rbf','linear'), key='Same') # Select one of options
```

Results:  
![selections](https://i.imgur.com/SSM9ayg.png)

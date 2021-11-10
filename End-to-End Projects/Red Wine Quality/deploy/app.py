import os
import pickle

import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.iolib.smpickle import load_pickle
from fastapi import FastAPI, HTTPException
from fastapi.responses import Response
import uvicorn


app = FastAPI(title='Deploying a ML Model with FastAPI')

## Load Model
with open('model.pickle', 'rb') as pickle_file:
    model = load_pickle(pickle_file)

@app.get("/")
def home():
    return "Congratulations! Your API is working as expected. Now head over to http://localhost:8000/docs."

@app.post("/predict") 
def prediction(alcohol: float, 
                sulphates: float,
                va: float,
                tsd: float):

    names = ['alcohol', 'sulphates', 'volatile acidity', 'total sulfur dioxide']
    df_value = pd.DataFrame(columns = names)
    df_value.loc[0] = [alcohol,sulphates,va,tsd]
    prediction = model.predict(df_value)[0]
    result = str(prediction).encode('utf-8','ignore')
    return Response(result)



import streamlit as st

import pandas as pd
import numpy as np

import pydeck as pdk
import plotly.express as px

DATA_URL = (
    '/home/portugapt/Documents/LearnHub/End-to-End Projects/Coursera Guided Projects/Build a Data Science Web App with Streamlit and Python/Motor_Vehicle_Collisions_-_Crashes.csv'
    )

st.title('Motor Vehicle Collisions in NYC - Streamlit App')

st.markdown('Streamlit dashboard to experiment with Streamlit.  \n\
            Analyse NY motor vehicle collisions (some emoji)')

@st.cache(persist=True)
def load_data(nrows):
    data = pd.read_csv(DATA_URL, nrows=nrows, parse_dates=[['CRASH_DATE', 'CRASH_TIME']])

    data.dropna(subset=['LATITUDE', 'LONGITUDE'], inplace = True)
    lowercase = lambda x: str(x).lower()
    data.rename(lowercase, axis='columns', inplace=True)
    data.rename(columns={'crash_date_crash_time': 'date/time'}, inplace = True)

    return data

data = load_data(100000)
original_data = data
midpoint = (np.average(data['latitude']), np.average(data['longitude']))


st.header('Where most people are injured in NYC?')
injured_people = st.slider('Minimum number of people injured in collisions', 0, 19)
st.map(data.query('injured_persons >= @injured_people')[['latitude', 'longitude']].dropna(how='any'))
## st.map implies a lat/lon feature (lat or latitude, lon or longitude)

st.header('How many collisions occour during a given time of day?')
hour = st.slider('hour to look at', 0, 23)
data = data[data['date/time'].dt.hour == hour]

st.markdown(f'Vehicle Collision between {hour}:00 and {hour+1}:00')


st.write(pdk.Deck(
    map_style='mapbox://styles/mapbox/light-v9',
    initial_view_state={
        'latitude': midpoint[0],
        'longitude': midpoint[1],
        'zoom': 11,
        'pitch': 50
    },
    layers=[
        pdk.Layer(
            "HexagonLayer",
            data=data[['date/time', 'longitude', 'latitude']],
            get_position=['longitude', 'latitude'],
            radius = 600,
            extruded=True,
            pickable=True,
            elevation_scale=4,
            elevation_range= [0, 1000]
        )
    ]
))

st.subheader(f'Breakdown by minute between {hour} and {hour+1}')
filtered = data[
    (data['date/time'].dt.hour >= hour) & (data['date/time'].dt.hour < (hour +1))
]
hist = np.histogram(filtered['date/time'].dt.minute, bins = 60, range=(0,60))[0]
chart_data = pd.DataFrame({'minute':range(60), 'crashes':hist})
fig = px.bar(chart_data, x='minute', y='crashes', hover_data=['minute', 'crashes'], height=500)
st.write(fig)

@st.cache(persist=True)
def dangerous_streets(type_of_people):
    return (original_data
            .query(f'injured_{type_of_people.lower()} >= 1')[['on_street_name', f'injured_{type_of_people.lower()}']]
            .sort_values(by=[f'injured_{type_of_people.lower()}'], ascending = False)
            .dropna(how='any')[:5])
    
st.header('Top 5 dangerous streets by affected type')
select = st.selectbox('Affected type of people', ['Pedestrians', 'Cyclists', 'Motorists'])

st.write(dangerous_streets(select))

if st.checkbox('Show raw data', False):
    st.subheader('Raw Data')
    st.write(data)


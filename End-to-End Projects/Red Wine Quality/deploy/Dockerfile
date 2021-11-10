FROM python:3.8-slim

ENV PYTHONUNBUFFERED True

WORKDIR /app

COPY ./requirements.txt ./requirements.txt
COPY app.py /app/app.py
COPY gunicorn_config.py /app/gunicorn_config.py
COPY model.pickle /app/model.pickle

RUN apt-get update -y \
    && apt-get install -y gcc libpq-dev \
    && pip3 install -r requirements.txt --no-cache-dir

CMD gunicorn app:app -c gunicorn_config.py
FROM python:3.9

ENV AIRFLOW_HOME=/usr/local/airflow

RUN apt-get update && \
    apt-get install -y libpq-dev && \
    apt-get install -y build-essential && \
    apt-get install -y libssl-dev libffi-dev && \
    apt-get install -y python3-dev

COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY dask.yaml /etc/dask/dask.yaml

RUN pip install --upgrade pip

RUN pip install apache-airflow[postgres,dask,jupyter]

RUN airflow initdb

RUN mkdir ${AIRFLOW_HOME}/dags

COPY dags/ ${AIRFLOW_HOME}/dags/

EXPOSE 8080 8888 8787 8786

CMD ["airflow", "webserver", "-p", "8080"]


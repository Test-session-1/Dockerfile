
FROM python:3.9
RUN pip install apache-airflow[postgres,gcp_api]
COPY airflow.cfg /root/airflow/airflow.cfg
EXPOSE 8080 5555
ENTRYPOINT ["airflow", "webserver"]

# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the input config files to the working directory
COPY airflow.cfg /app/
COPY jupyter_notebook_config.py /app/
COPY dask.yaml /app/

# Install necessary packages
RUN pip install apache-airflow[postgres, celery, rabbitmq]
RUN pip install jupyterlab
RUN pip install dask dask-ml

# Expose the Airflow and JupyterLab ports
EXPOSE 8080 8888

# Run Airflow and JupyterLab
CMD airflow initdb && airflow webserver -p 8080 & jupyter lab --port 8888 --no-browser --ip=0.0.0.0 --allow-root & dask-docker dask.yaml up

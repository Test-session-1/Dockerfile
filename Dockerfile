FROM python:3.9

# Install Airflow, JupyterLab, and Dask
RUN pip install apache-airflow[all] jupyterlab dask

# Copy config files
COPY airflow.cfg /root/airflow/airflow.cfg
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY dask.yaml /root/dask.yaml

# Start Airflow, JupyterLab, and Dask
CMD airflow webserver -p 8080 && airflow scheduler && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root && dask-worker localhost:8786 --worker-port 8787 --memory-limit 2GB

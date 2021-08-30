FROM jupyter/datascience-notebook

COPY ./requirements.txt /tmp/
COPY ./notebooks /home/jovyan/notebooks
COPY ./k6_scripts /home/jovyan/k6_scripts

RUN pip install --requirement /tmp/requirements.txt

USER root

RUN apt-get update && sudo apt-get install ca-certificates gnupg2 -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
RUN echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
RUN apt-get update && apt-get install k6

RUN chmod -R 777 /home/jovyan/notebooks
RUN chmod -R 777 /home/jovyan/k6_scripts

USER 1000
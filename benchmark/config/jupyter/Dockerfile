FROM jupyter/datascience-notebook

COPY ./requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

USER root

RUN apt-get update && apt-get install -y gnupg2
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
RUN echo "deb https://dl.bintray.com/loadimpact/deb stable main" | sudo tee -a /etc/apt/sources.list
RUN apt-get update && apt-get install k6

USER 1000
FROM docker:dind

WORKDIR /tmp

RUN apk update && apk add bash curl

RUN curl https://releases.hashicorp.com/boundary/0.1.4/boundary_0.1.4_linux_amd64.zip -o boundary.zip
RUN unzip boundary.zip
RUN mv boundary /usr/local/bin 
RUN rm boundary.zip

EXPOSE 9200
EXPOSE 9201
EXPOSE 9202

ENTRYPOINT [ "/bin/bash", "-l", "-c", "dockerd & sleep 1s && boundary dev"]

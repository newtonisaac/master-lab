# benchmark machine docker
FROM docker:dind

WORKDIR /benchmark

RUN apk add --no-cache iptables git bash curl coreutils nano
RUN apk add --no-cache docker-compose

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY docker-compose.yml ./
RUN mkdir jupyter

CMD /entrypoint.sh
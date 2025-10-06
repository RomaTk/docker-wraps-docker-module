ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

WORKDIR /working-env/docker/dind

COPY ./start-docker-deamon.sh ./start-docker-deamon.sh
COPY ./stop-docker-deamon.sh ./stop-docker-deamon.sh
COPY ./reset-docker-processes-file.sh ./reset-docker-processes-file.sh

RUN mv /bin/docker ./docker-original

COPY ./docker.sh /bin/docker
RUN chmod +x /bin/docker
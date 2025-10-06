ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

WORKDIR /working-env/docker

VOLUME [ "/working-env/docker/configs" ]

COPY ./main.sh ./main.sh
RUN chmod +x ./main.sh
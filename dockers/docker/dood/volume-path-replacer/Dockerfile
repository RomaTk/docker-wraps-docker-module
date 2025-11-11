ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

WORKDIR /working-env/docker/dood/volume-path-replacer

VOLUME [ "/working-env/docker/dood/volume-path-replacer/config.cfg" ]

RUN cp /bin/docker /bin/docker-orig
COPY docker.sh /bin/docker
RUN chmod +x /bin/docker
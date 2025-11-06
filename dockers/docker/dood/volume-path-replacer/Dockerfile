ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

ARG REPLACE_WITH
ARG TO_REPLACE

WORKDIR /working-env/docker/dood/volume-path-replacer
RUN echo "REPLACE_WITH=\"${REPLACE_WITH}\"" > ./config.cfg
RUN echo "TO_REPLACE=\"${TO_REPLACE}\"" >> ./config.cfg

RUN cp /bin/docker /bin/docker-orig
COPY docker.sh /bin/docker
RUN chmod +x /bin/docker
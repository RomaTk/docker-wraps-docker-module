ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

WORKDIR /working-env/docker/volume-path-replacer

# Ideally should be this line, but some systems have issues with mounting the docker socket
# so we leave it commented out for now.
# VOLUME [ "/working-env/docker/volume-path-replacer/config.cfg" ]
RUN cp /bin/docker /bin/docker-orig
COPY docker.sh /bin/docker
RUN chmod +x /bin/docker
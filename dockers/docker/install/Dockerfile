ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

ARG VERSION=""
ARG ARCH=""
ARG OS=""
RUN echo "Using version ${VERSION}"
RUN echo "Using architecture ${ARCH}"
RUN echo "Using OS ${OS}"

# USED FOR NON-INTERACTIVE INSTALLATION
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /working-env/docker

COPY ./saved-versions/${OS}-${ARCH}-${VERSION}.tgz ./saved-versions/downloaded.tgz

COPY ./install.sh ./install.sh
RUN chmod +x ./install.sh

RUN ./install.sh

RUN rm -rf ./install.sh
RUN rm -rf ./saved-versions
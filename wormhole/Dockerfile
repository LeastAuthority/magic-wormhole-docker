# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

# Avoid interactive frontend
ENV DEBIAN_FRONTEND="noninteractive"

# Install some required packages for testing
RUN INSTALL_PKGS="git" && \
    apt-get -q clean && \
    apt-get -q update && \
    apt-get install -y $INSTALL_PKGS && \
    apt-get -q clean

WORKDIR /app

ARG VERSION_TAG
RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade git+https://github.com/magic-wormhole/magic-wormhole.git@${VERSION_TAG}#egg=magic-wormhole

CMD wormhole

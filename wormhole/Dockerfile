# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/

WORKDIR /app

ARG VERSION_TAG
RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r requirements.txt

CMD wormhole

LABEL org.opencontainers.image.title="Magic Wormhole CLI"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole implementation and CLI"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/wormhole"
LABEL org.opencontainers.image.vendor="LeastAuthority TFA GmbH"

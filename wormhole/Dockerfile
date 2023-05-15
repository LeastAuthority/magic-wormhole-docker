# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

RUN apt-get update && apt-get install -y \
    git \
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

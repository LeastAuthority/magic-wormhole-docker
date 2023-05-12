# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

COPY requirements.txt /app/

WORKDIR /app

ARG VERSION_TAG
RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r requirements.txt

CMD wormhole

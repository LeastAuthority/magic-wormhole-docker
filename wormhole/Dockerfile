# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

# Metadata
LABEL org.opencontainers.image.title="Magic Wormhole CLI"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole implementation and CLI"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/wormhole"
LABEL org.opencontainers.image.vendor="LeastAuthority TFA GmbH"

# Install the application
COPY requirements.txt /app/

RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r /app/requirements.txt

# Default command to start the application
CMD wormhole

WORKDIR /app

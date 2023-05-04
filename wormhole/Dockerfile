# Pull official base image from DockerHub
FROM python:3.9.16-slim-bullseye

WORKDIR /app

ARG VERSION_TAG
RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade https://github.com/magic-wormhole/magic-wormhole/tarball/${VERSION_TAG}#egg=magic-wormhole

CMD wormhole

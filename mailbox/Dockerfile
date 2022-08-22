FROM python:3.9.13-slim-buster

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt-get update
RUN apt-get -y install git

WORKDIR /app

RUN pip install git+https://github.com/magic-wormhole/magic-wormhole-mailbox-server.git
CMD bash -c "twist wormhole-mailbox"

FROM python:3.9.13-slim-buster

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt-get update
RUN apt-get -y install git

WORKDIR /app

RUN pip install git+https://github.com/magic-wormhole/magic-wormhole-transit-relay.git#egg=magic-wormhole-transit-relay 
CMD bash -c "twist transitrelay --port=tcp:4001 --websocket=tcp:4002"

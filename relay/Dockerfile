FROM pypy:3.9-7.3.9-bullseye

VOLUME /db

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt update
RUN apt install rustc -y

WORKDIR /app

ARG VERSION_TAG
RUN pip install git+https://github.com/magic-wormhole/magic-wormhole-transit-relay.git@${VERSION_TAG}#egg=magic-wormhole-transit-relay

CMD twist transitrelay --usage-db=/db/usage-transitrelay.sqlite --blur-usage 3600 --port=tcp:4001 --websocket=tcp:4002

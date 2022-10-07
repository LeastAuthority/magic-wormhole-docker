FROM pypy:3.9-bullseye

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt update
RUN apt install rustc -y

WORKDIR /app

RUN pip install git+https://github.com/magic-wormhole/magic-wormhole-transit-relay.git@0.2.1-143-gdb48e91#egg=magic-wormhole-transit-relay

CMD twist transitrelay --blur-usage 3600 --port=tcp:4001 --websocket=tcp:4002

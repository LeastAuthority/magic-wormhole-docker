FROM pypy:3.9-7.3.11-slim-bullseye

RUN apt-get update && apt-get install -y \
    git rustc \
    && rm -rf /var/lib/apt/lists/*

VOLUME /db

COPY requirements.txt /app/

WORKDIR /app

ARG VERSION_TAG
RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r requirements.txt

CMD twist transitrelay --usage-db=/db/usage-transitrelay.sqlite --blur-usage 3600 --port=tcp:4001 --websocket=tcp:4002

LABEL org.opencontainers.image.title="Magic Wormhole relay"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole relay service"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/relay"
LABEL org.opencontainers.image.vendor="LeastAuthority TFA GmbH"

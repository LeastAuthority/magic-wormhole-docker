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

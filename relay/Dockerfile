FROM pypy:3.9-7.3.11-slim-bullseye

RUN apt-get update && apt-get install -y \
    rustc \
    && rm -rf /var/lib/apt/lists/*

# Metadata
LABEL org.opencontainers.image.title="Magic Wormhole relay"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole relay service"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/relay"
LABEL org.opencontainers.image.vendor="Least Authority TFA GmbH"

# Install the application
COPY requirements.txt /app/

RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r /app/requirements.txt

# Default parameters and command to start
ENV MW_RELAY_BLUR_USAGE="3600"
ENV MW_RELAY_PROTO="tcp"
ENV MW_RELAY_PORT="4001"
ENV MW_RELAY_WS_PROTO="tcp"
ENV MW_RELAY_WS_PORT="4200"

CMD twist transitrelay \
    --usage-db="/db/usage-transitrelay.sqlite" \
    --blur-usage="${MW_RELAY_BLUR_USAGE}" \
    --port="${MW_RELAY_PROTO}:${MW_RELAY_PORT}" \
    --websocket="${MW_RELAY_WS_PROTO}:${MW_RELAY_WS_PORT}"

# Persistent data
VOLUME /db

# Expose ports
EXPOSE "${MW_RELAY_PORT}/${MW_RELAY_PROTO}" "${MW_RELAY_WS_PORT}/${MW_RELAY_WS_PROTO}"

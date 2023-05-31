FROM pypy:3.9-7.3.11-slim-bullseye

RUN apt-get update && apt-get install -y \
    rustc \
    && rm -rf /var/lib/apt/lists/*

# Metadata
LABEL org.opencontainers.image.title="Magic Wormhole mailbox"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole mailbox service"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/mailbox"
LABEL org.opencontainers.image.vendor="Least Authority TFA GmbH"

# Install the application
COPY requirements.txt /app/

RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r /app/requirements.txt

# Copy welcome message as file to load with newlines symbols in parameters
# FIXME: This motd should not be shipped in this image (configured downstream)
COPY welcome.motd /app/welcome.motd

# Default parameters and command to start
ENV MW_MAILBOX_BLUR_USAGE="3600"
ENV MW_MAILBOX_PROTO="tcp"
ENV MW_MAILBOX_PORT="4000"

CMD twist wormhole-mailbox \
    --channel-db="/db/relay.sqlite" \
    --usage-db="/db/usage-relay.sqlite" \
    --blur-usage="${MW_MAILBOX_BLUR_USAGE}" \
    --port="${MW_MAILBOX_PROTO}:${MW_MAILBOX_PORT}" \
    --motd "$(cat /app/welcome.motd)"

# Persistent data
VOLUME /db

# Expose port
EXPOSE "${MW_MAILBOX_PORT}/${MW_MAILBOX_PROTO}"

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

# Copy welcome message as file to load with newlines symbols in parameters
COPY welcome.motd welcome.motd

# --blur-usage=3600 Logging time rounded to 1 hour and turns off request-logging
CMD twist wormhole-mailbox --channel-db=/db/relay.sqlite --usage-db=/db/usage-relay.sqlite --blur-usage=3600 --motd "$(cat welcome.motd)"

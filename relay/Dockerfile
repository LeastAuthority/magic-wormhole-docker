FROM pypy:3.9-7.3.11-slim-bullseye

RUN apt-get update && apt-get install -y \
    rustc \
    && rm -rf /var/lib/apt/lists/*

# Metadata
LABEL org.opencontainers.image.title="Magic Wormhole relay"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole relay service"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/relay"
LABEL org.opencontainers.image.vendor="LeastAuthority TFA GmbH"

# Install the application
COPY requirements.txt .

RUN pip install \
    --disable-pip-version-check \
    --no-cache \
    --upgrade \
    -r requirements.txt

# Parameters for default user:group
ARG uid=1000
ARG user=appuser
ARG gid=1000
ARG group=appgroup

# Add group and user so the command above and its
# output will be owned by the specified uid:gid
# These steps will fail explicitely on conflict
RUN getent group "${gid}" > /dev/null \
    || groupadd -g "${gid}" "${group}"; \
    test "$(getent group "${gid}")" = "$(getent group "${group}")" \
    || { echo "Group name/id conflict!"; exit 1; }
RUN id "${uid}" > /dev/null 2>&1 \
    || useradd -md "/home/${user}" -s /bin/bash -g "${group}" -u "${uid}" "${user}"; \
    test "$(id "${uid}")" = "$(id "${user}")" \
    || { echo "User name/id conflict!"; exit 1; }

# Prepare directories with ownership
RUN { test -d /db || mkdir /db; } && chown -R ${user}:${group} /db

# Switch to non-root user
USER ${user}
WORKDIR /app

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

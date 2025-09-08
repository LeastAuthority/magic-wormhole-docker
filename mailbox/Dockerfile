FROM pypy:3.10-7.3.19-slim-bookworm@sha256:5d18aa0232059c991ff8d52f1b528a6ff8f55c86154ba248a270a6eb90975f3a

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

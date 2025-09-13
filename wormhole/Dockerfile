# Pull official base image from DockerHub
FROM python:3.11.13-slim-bookworm@sha256:873f91540d53b36327ed4fb018c9669107a4e2a676719720edb4209c4b15d029

# Metadata
LABEL org.opencontainers.image.title="Magic Wormhole CLI"
LABEL org.opencontainers.image.description="Docker image to run the Magic Wormhole implementation and CLI"
LABEL org.opencontainers.image.source="https://github.com/LeastAuthority/magic-wormhole-docker/wormhole"
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

# Switch to non-root user
USER ${user}
WORKDIR /app

# Default command to start the application
CMD wormhole

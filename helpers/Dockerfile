# Pull official base image from DockerHub
FROM python:3.10.19-slim-bookworm@sha256:c6a0f79dabcf0935761feb5a3e816bbdca2b9e8aa887ac7daf4ba11c5708027c

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
CMD bash

FROM pypy:3.9-bullseye

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt update
RUN apt install rustc -y

WORKDIR /app

ARG VERSION_TAG
RUN pip install git+https://github.com/magic-wormhole/magic-wormhole-mailbox-server.git@${VERSION_TAG}#egg=magic-wormhole-mailbox-server

# Copy welcome message as file to load with newlines symbols in parameters
COPY welcome.motd welcome.motd

CMD twist wormhole-mailbox --blur-usage=3600 --motd "$(cat welcome.motd)"

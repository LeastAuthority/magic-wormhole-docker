FROM pypy:3.9-7.3.9-bullseye

COPY Pipfile /app/Pipfile
COPY Pipfile.lock /app/Pipfile.lock

RUN apt update
RUN apt install rustc -y

WORKDIR /app

ARG VERSION_TAG
RUN pip install --upgrade git+https://github.com/magic-wormhole/magic-wormhole.git@${VERSION_TAG}#egg=magic-wormhole

CMD wormhole

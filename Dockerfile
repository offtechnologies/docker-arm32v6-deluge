
FROM offtechnologies/docker-arm32v6-base-image-alpine-qemu:latest

ARG DELUGE_VERSION=1.3.15-r0

COPY start /usr/local/bin/start
COPY config /config

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk -U upgrade --no-cache\
    && apk add --no-cache \
    bash \
    py-pip \
    py2-mako \
    deluge@testing=${DELUGE_VERSION} && \
    rm -rf /var/cache/apk/* && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip2 install incremental constantly packaging automat service_identity py2-mako && \
    chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]

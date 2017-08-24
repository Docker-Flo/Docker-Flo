# ----------------------------------
# CorinthMC Core Dockerfile
# Environment: Java
# Version: 1.0.0
# ----------------------------------
FROM openjdk:8-jdk-alpine

MAINTAINER Fonix Hardcastle, <me@fonix.online>

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update curl ca-certificates openssl curl sudo git tar bash sqlite \
    && adduser -D -h /home/container container \
    && echo "ALL            ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers \
    && chown root:root /usr/bin \
    && chmod u+s /usr/bin/sudo

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]

FROM debian:jessie
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL Role="cache"

ARG SERVICE_PORT
ARG ADMIN_NAME
ARG ADMIN_PASS
ARG ADMIN_SHELL
ARG ADMIN_SSHKEY

ENV PACKAGE="bash wget memcached openssh-server" \
    ADMIN_NAME=${ADMIN_NAME:-admin} \
    ADMIN_PASS=${ADMIN_PASS:-admin} \
    ADMIN_SHELL=${ADMIN_PASS:-/bin/sh} \
    ADMIN_SSHKEY=${ADMIN_SSHKEY} \
    SERVICE_PORT=${SERVICE_PORT:-11211}

RUN apt-get update && apt-get install -y ${PACKAGE}

COPY memcached.conf /etc/memcached.conf
COPY start.sh /start.sh

# admin user
RUN useradd -b /home -d /home/${ADMIN_NAME} -p ${ADMIN_PASS} -s ${ADMIN_SHELL} -m ${ADMIN_NAME}
RUN mkdir /home/admin/.ssh  && chown -R admin:admin /home/admin/.ssh

ENTRYPOINT ["/start.sh"]
CMD [""]
EXPOSE 22

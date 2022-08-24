FROM debian:stable-slim

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
        build-essential \
        git \
        libsecret-1-dev \
        fakeroot \
        rpm \
        python2 \
        libnss3-dev \
        libx11-dev \
        libgdk-pixbuf2.0-dev \
        libgtk-3-dev \
        libxss-dev \
        libasound2-dev \
        libxkbfile-dev \
        sudo \
        && \
    rm -rf /var/lib/apt/lists/*

ADD https://nodejs.org/dist/v16.17.0/node-v16.17.0-linux-x64.tar.xz /opt/node-v16.17.0-linux-x64.tar.xz
RUN cd /opt && tar xf node-v16.17.0-linux-x64.tar.xz && ln -s node-v16.17.0-linux-x64 node

ENV PATH="${PATH}:/opt/node/bin"

RUN npm config set python /usr/bin/python2 --global

RUN useradd --create-home builder && usermod -aG sudo builder
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder

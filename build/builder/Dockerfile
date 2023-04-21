FROM ghcr.io/thoai-runner/runner/runner

ARG DOCKER_GPG_KEY=7EA0A9C3F273FCD8
ARG DOCKER_VERSION=5:23.0.3-1~ubuntu.20.04~focal
RUN gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys ${DOCKER_GPG_KEY} 2>>/dev/null && \
    gpg --export ${DOCKER_GPG_KEY} | tee /etc/apt/trusted.gpg.d/docker.gpg >>/dev/null && \
    echo 'deb https://download.docker.com/linux/ubuntu focal stable' | sudo tee /etc/apt/sources.list.d/docker.list >>/dev/null && \
    apt-get -qq update && \
    apt-get -qq install -y docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION}

#CMD ["docker", "login harbor.elofun.net", "--username thoai.phan", "--password kbbJwdZhhP7kXhMawFzq7KKBM3DFNX8K"]

ENV DOCKER_HOST=tcp://localhost:2376
ENV DOCKER_TLS_VERIFY=1
ENV DOCKER_CERT_PATH=/certs/client

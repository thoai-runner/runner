FROM ghcr.io/thoai-runner/runner/runner

ARG K8S_GPG_KEY=B53DC80D13EDEF05
ARG K8S_VERSION=1.24.12-00
RUN gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys ${K8S_GPG_KEY} 2>>/dev/null && \
    gpg --export ${K8S_GPG_KEY} | tee /etc/apt/trusted.gpg.d/kubernetes.gpg >>/dev/null && \
    echo 'deb https://apt.kubernetes.io kubernetes-xenial main' | tee /etc/apt/sources.list.d/kubernetes.list >>/dev/null && \
    apt-get -qq update && \
    apt-get -qq install -y kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION}

RUN curl -sL raw.github.com/helm/helm/main/scripts/get-helm-3 | bash -s -

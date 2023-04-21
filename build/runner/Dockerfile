FROM ghcr.io/thoai-runner/runner/base

WORKDIR /opt/actions-runner
RUN curl -sL $(curl -sL api.github.com/repos/actions/runner/releases/latest | jq -r '.assets[] | select(.name | test("^actions-runner-linux-x64-[0-9.]+\\.tar\\.gz$")) | .browser_download_url') | tar -xz

RUN ./bin/installdependencies.sh

RUN useradd -d $(pwd) -r -s $(which bash) runner && \
    chown runner: -R $(pwd)

COPY run.sh /
ENTRYPOINT [ "/run.sh" ]

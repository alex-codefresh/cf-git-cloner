FROM alpine:3.10.3

RUN apk add --no-cache git~=2.22 bash openssh

# install git-lfs
RUN apk add --no-cache --virtual deps openssl && \
    export ARCH=$([[ "$(uname -m)" == "aarch64" ]] && echo "arm64" || echo "amd64") && \
    wget -qO- https://github.com/git-lfs/git-lfs/releases/download/v2.12.1/git-lfs-linux-${ARCH}-v2.12.1.tar.gz | tar xz && \
    mv git-lfs /usr/bin/ && \
    git lfs install && \
    apk del deps

#add ssh record on which ssh key to use
COPY ./.ssh/ /root/.ssh/

COPY ./start.sh /run/start.sh
RUN chmod +x /run/start.sh

CMD ["/run/start.sh"]

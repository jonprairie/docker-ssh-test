FROM ubuntu:22.04

# we need ca-certificates in order to accept TLS handshakes (eg pushing to github)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server \
    bash \
    dos2unix \
    git \
    ca-certificates

# config derived from: https://github.com/JAremko/drop-in/blob/master/sshd_config
COPY sshd_config /etc/ssh/sshd_config

# create .ssh directory and save github as a recognized host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# resolve weird "Missing privilege separation directory: /run/sshd" error when trying to run sshd
RUN service ssh start
RUN service ssh stop

COPY start.sh /root/temp_start.sh

# start.sh was written in windows, so ensure compatible line endings
RUN dos2unix -n /root/temp_start.sh /usr/local/bin/start.sh

ENTRYPOINT ["bash", "/usr/local/bin/start.sh"]
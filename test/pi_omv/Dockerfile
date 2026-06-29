# Throwaway Debian Bookworm image for pi_omv phase-1 integration tests.

FROM debian:bookworm

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        iproute2 \
        rsync \
        sudo \
        wget \
    && rm -rf /var/lib/apt/lists/*

ARG TEST_USER=testuser
RUN useradd -m -G sudo -s /bin/bash "$TEST_USER" \
    && echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV USER=$TEST_USER
USER $TEST_USER
WORKDIR /home/$TEST_USER

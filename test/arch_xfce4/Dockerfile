# Throwaway Arch image for dotfiles bootstrap integration tests.
ARG DOCKER_PLATFORM=linux/amd64
FROM --platform=${DOCKER_PLATFORM} archlinux:base-devel

# Pin a reliable mirror for CI (override at build if needed).
RUN sed -i 's/^#Server = .*$/Server = https:\/\/geo.mirror.pkgbuild.com\/\$repo\/os\/\$arch/' /etc/pacman.d/mirrorlist

# pacman's alpm sandbox conflicts with Docker's seccomp during build/run.
RUN printf '\n[options]\nDisableSandbox\n' >> /etc/pacman.conf

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm --needed sudo rsync \
    && pacman -Scc --noconfirm

ARG TEST_USER=testuser
RUN useradd -m -G wheel -s /bin/bash "$TEST_USER" \
    && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV USER=$TEST_USER
USER $TEST_USER
WORKDIR /home/$TEST_USER

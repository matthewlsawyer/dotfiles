# FROM base/archlinux
FROM antergos/archlinux-base-devel

# Create a test user
RUN useradd --create-home testuser \
    && echo 'testuser:testuser' | chpasswd \
    && groupadd sudo \
    && usermod -aG sudo testuser \
    && echo '%sudo      ALL=(ALL) ALL' >> /etc/sudoers \
    && mkdir -p /home/testuser/dotfiles

# Copy the project into home directory
COPY / /home/testuser/dotfiles
WORKDIR /home/testuser/dotfiles

USER testuser

ENTRYPOINT /bin/bash

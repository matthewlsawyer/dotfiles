# FROM base/archlinux
FROM antergos/archlinux-base-devel

# Create a test user
RUN useradd --create-home test \
    && echo 'test:test' | chpasswd \
    && groupadd sudo \
    && usermod -aG sudo test \
    && echo '%sudo      ALL=(ALL) ALL' >> /etc/sudoers

# Copy the project into home directory
COPY / /home/test/dotfiles
WORKDIR /home/test/dotfiles

USER test

ENTRYPOINT /bin/bash
# ENTRYPOINT ["./entrypoint.sh", "arch_xfce4"]

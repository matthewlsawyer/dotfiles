#!/bin/sh

# arch_xfce4 profile overrides (XFCE desktop)

BROWSER=/usr/bin/firefox

# LESS highlighting
export LESSOPEN="| pygmentize %s"
export LESS="-R "

# VTE support for Tilix
# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] && [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Base16 shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SESSION_TYPE="x11"

if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
    echo "\$XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) not writable. Unsetting." >&2
    unset XDG_RUNTIME_DIR
else
    export XDG_RUNTIME_DIR
fi

# Generate .gitingore files using gitingore.io
#  Use `gi list` for a list of all supported files
function _gi() { curl -L -s https://www.gitignore.io/api/$@; }
function gi() { _gi $@ > $(pwd)/.gitignore; }

# Npm global installs
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

#!/bin/bash

# Optional — media players and codecs.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install vlc ffmpeg smplayer ncmpcpp
aur_install codecs64

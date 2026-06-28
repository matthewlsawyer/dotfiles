#!/bin/bash

# Optional — media players and codecs.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SHARED_ROOT/scripts/lib/sudov.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pinstall vlc ffmpeg smplayer ncmpcpp
yinstall codecs64

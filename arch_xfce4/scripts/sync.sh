#!/bin/bash

# Contract: sync — apply path; bootstrap pipeline step 4 — sync.sh
#
# Apply:     invoked by apply.sh (default)
# Bootstrap: step 4 of installer → packages → desktop → sync → postinstall
# See install/README.md.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/init.sh
. "$SCRIPT_DIR/lib/init.sh"

rsync -avh --no-perms "$DOTFILES_PLATFORM_ROOT/dotfiles/" ~/

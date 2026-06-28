#!/bin/bash

# Optional — pipx for ad-hoc CLI tools (not individual apps).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../../macos/scripts/lib/init.sh
. "$SCRIPT_DIR/../../../macos/scripts/lib/init.sh"

brew install pipx
pipx ensurepath

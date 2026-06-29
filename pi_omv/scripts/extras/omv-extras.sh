#!/bin/bash

# Optional — omv-extras.org plugin repo (often preinstalled by Pi installScript).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

INSTALL_URL="https://github.com/OpenMediaVault-Plugin-Developers/packages/raw/master/install"

wget -O - "$INSTALL_URL" | sudo bash

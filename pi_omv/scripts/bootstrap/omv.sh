#!/bin/bash

# Bootstrap phase 2 — OMV 7 via installScript (Bookworm → sandworm). Run after reboot.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

INSTALL_URL="https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install"

if dpkg -l openmediavault 2>/dev/null | awk '$2 == "openmediavault" && $1 == "ii" { found=1 } END { exit !found }'; then
    echo "openmediavault already installed — skipping"
    exit 0
fi

wget -O - "$INSTALL_URL" | sudo bash -s -- -r

echo "==> OMV web UI: http://$(hostname -I | awk '{print $1}')/ (admin / openmediavault)"
echo "==> Run updates in System → Update Management; reboot if prompted"
echo "==> adduser -m <user> is manual — see README.md"

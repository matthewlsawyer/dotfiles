#!/bin/bash

# Bootstrap phase 1 — base packages and OMV preinstall. Reboot before omv.sh.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

PREINSTALL_URL="https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/preinstall"

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y vim git wget ca-certificates
wget -O - "$PREINSTALL_URL" | sudo bash

echo "==> Reboot required before omv.sh — see README.md"
echo "==> Run sudo raspi-config manually if not done (locale, SSH, boot options)"

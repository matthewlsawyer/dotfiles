#!/bin/bash

# Optional — interactive ssh and gpg key setup. Run after bootstrap when ready.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

echo "Generating SSH key (interactive)..."
ssh-keygen

echo "Generating GPG key (interactive)..."
gpg --full-gen-key

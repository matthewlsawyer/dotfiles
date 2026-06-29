#!/bin/bash

# Optional — ufw baseline (does not enable ufw).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
. "$DOTFILES_SCRIPTS_ROOT/lib/functions.sh"

pkg_install ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH

cat <<'EOF'
ufw configured (not enabled). When ready: sudo ufw enable
EOF

#!/bin/bash

# postinstall.sh — two-phase bootstrap hints.

cat <<EOF
postinstall.sh:
  Phase 1 (setup.sh + preinstall) → reboot → phase 2 (omv.sh)
  Manual: raspi-config, adduser — see README.md
  Optional: pi_omv/scripts/extras/
EOF
exit 0

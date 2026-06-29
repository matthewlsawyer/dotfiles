#!/bin/bash

# packages.sh — core formulae. Optional tiers: apps/dev.sh, apps/browsers.sh, …

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

# Shell / CLI minimum
brew install git wget htop jq

# Contract — run_sync (apply.sh)
brew install rsync

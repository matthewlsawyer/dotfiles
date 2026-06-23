#!/bin/bash

# Contract: bootstrap pipeline step 2 — packages.sh
# Core formulae only. Optional tiers: apps/dev.sh, apps/browsers.sh, …

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"

# Shell / CLI minimum
brew install git wget htop jq httpie mac2unix

# Contract — sync.sh (when macos/dotfiles/ exists)
brew install rsync

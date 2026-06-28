#!/bin/bash

# packages.sh — core formulae. Optional tiers: apps/dev.sh, apps/browsers.sh, …

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/init.sh
. "$SCRIPT_DIR/../lib/init.sh"
# shellcheck source=../lib/functions.sh
. "$SCRIPT_DIR/../lib/functions.sh"

# Shell / CLI minimum
pkg_install git wget htop jq httpie mac2unix

# Contract — run_sync (apply.sh)
pkg_install rsync

#!/bin/bash

# Contract: bootstrap pipeline step 1 — installer.sh
# Install Homebrew. See install/README.md.
#
# On Apple Silicon, consider the official install script at https://brew.sh
# (the Ruby one-liner below targets Intel / legacy macOS).

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#!/bin/bash

# Script to sync the dotfiles

. sudov.sh
. functions.sh

# Get rsync
pinstall rsync

# Sync up dotfiles
rsync -avh --no-perms ../dotfiles ~

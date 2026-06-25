#!/bin/bash

# Keep sudo credential alive during long installs.

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

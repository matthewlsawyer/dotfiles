#!/bin/bash

# This file installs and sets up node and npm.

. sudov.sh
. functions.sh

# Node
pinstall nodejs npm

# Set npm prefix to use local directory
NPM_PACKAGES="${HOME}/.npm-packages"
mkdir -p "$NPM_PACKAGES"
npm config set prefix "$NPM_PACKAGES"

# Global npm packages
npm install -g typescript @angular/cli
npm install -g tslint eslint jslint

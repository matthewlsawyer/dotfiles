#!/bin/sh

# Get all the packages we need

# Set application directory option
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# Essentials
#

brew install wget
brew install htop

#
# Various apps
#

brew cask install firefox
brew cask install spotify

#
# Development tools
#

brew install git
brew cask install docker

# VS Code
brew cask install visual-studio-code

# VS Code extensions
#  TODO these behave weird for some reason
code --install-extension eamodio.gitlens
code --install-extension mikael.angular-beastcode
code --install-extension PeterJausovec.vscode-docker
code --install-extension EditorConfig.editorconfig
code --install-extension ms-vscode.go
code --install-extension redhat.java
code --install-extension mathiasfrohlich.kotlin
code --install-extension yzhang.markdown-all-in-one
code --install-extension ms-python.python
code --install-extension robinbentley.sass-indented
code --install-extension rbbit.typescript-hero
code --install-extension eg2.vscode-npm-script
code --install-extension ms-vscode.csharp
code --install-extension eg2.tslint
code --install-extension ajhyndman.jslint
code --install-extension dbaeumer.vscode-eslint

brew install go

# Node
brew install node
npm install -g gulp less
npm install -g typescript @angular/cli
npm install -g tslint eslint jslint

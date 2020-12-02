#!/bin/sh

# Get all the packages we need

# Set application directory option
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# Essentials
#

brew install wget
brew install htop
brew install jq
brew install httpie
brew install mac2unix

# Todoist CLI
#brew tap sachaos/todoist
#brew install todoist

#
# Various apps
#

brew cask install firefox
brew cask install spotify

# GTD
brew cask install todoist
brew cask install evernote

#
# Development tools
#

brew install git
brew cask install docker

# VS Code
brew cask install visual-studio-code
brew cask install visual-studio-code-insiders

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

# Go
brew install go

# Kotlin
brew install gcc
brew install kotlin

# Node
brew install node
npm install -g gulp less
npm install -g typescript @angular/cli
npm install -g tslint eslint jslint

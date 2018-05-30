#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colorize ls
alias ls='ls --color=auto'

# Program defaults
BROWSER=/usr/bin/firefox
VISUAL=/usr/bin/vim --nofork
EDITOR=/usr/bin/vim

# LESS highlighting
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS="-R "

# Local binaries
export PATH=$PATH:~/.local/bin

# VTE support for Tilix
# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] && [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi
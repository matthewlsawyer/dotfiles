#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Program defaults
BROWSER=/usr/bin/firefox
VISUAL=/usr/bin/vim
EDITOR=/usr/bin/vim

# LESS highlighting
export LESSOPEN="| pygmentize %s"
export LESS="-R "

# Local binaries
export PATH=$PATH:~/.local/bin

# VTE support for Tilix
# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] && [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi
#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Program defaults
BROWSER=/usr/bin/firefox
VISUAL=/usr/bin/vim --nofork
EDITOR=/usr/bin/vim

# LESS highlighting
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS="-R "
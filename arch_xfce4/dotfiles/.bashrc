#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Kick off the commonrc script
[[ -f ~/.commonrc ]] && . ~/.commonrc

# Bash specific stuff below

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# Check the window size after each command and, if necessary,
#  update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
#  match all files and zero or more directories and subdirectories.
shopt -s globstar

#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.commonrc ]] && . ~/.commonrc

export LANG=en_US.UTF-8

HIST_STAMPS="mm/dd/yyyy"
SAVEHIST=10000
HISTFILE=~/.zsh_history

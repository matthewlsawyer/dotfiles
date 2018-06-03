#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Kick off the commonrc script
[[ -f ~/.commonrc ]] && . ~/.commonrc

# Bash specific stuff below

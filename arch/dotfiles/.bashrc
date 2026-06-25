#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.commonrc ]] && . ~/.commonrc

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s checkwinsize
shopt -s globstar

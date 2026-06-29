#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.commonrc ]] && . ~/.commonrc

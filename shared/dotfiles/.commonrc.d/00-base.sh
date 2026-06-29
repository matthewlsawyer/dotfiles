#!/bin/sh

# Shared base — aliases, editor, PATH (cross-platform)

# Aliases — GNU vs BSD
if ls --color=auto >/dev/null 2>&1; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -G'
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sume='sudo -E -s'

# Program defaults
if command -v vim >/dev/null 2>&1; then
    VISUAL="$(command -v vim)"
    EDITOR="$VISUAL"
fi

# Local binaries
export PATH=~/.local/bin:$PATH

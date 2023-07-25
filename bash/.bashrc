#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Configure GPG
# This is needed to sign git commits
export GPG_TTY=$(tty)

# Configure editor
export VISUAL="$(command -v nvim 2>/dev/null)"
export EDITOR="$(command -v nvim 2>/dev/null || command -v vim 2>/dev/null || command -v nano)"

# ghcup (Haskell)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env


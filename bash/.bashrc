#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

colorize() {
  echo -e "\e[$1$2\e[m"
}

PS1='['
PS1+=$(colorize '92m' '\u@\h')
PS1+=':'
PS1+=$(colorize '94m' '\w')
PS1+=']'
PS1+=$(colorize '93m' '$(parse_git_branch)')
PS1+='\$ '

# Configure GPG
# This is needed to sign git commits
export GPG_TTY=$(tty)

# Configure editor
export VISUAL="$(command -v nvim 2>/dev/null)"
export EDITOR="$(command -v nvim 2>/dev/null || command -v vim 2>/dev/null || command -v nano)"
alias vim='nvim'

# ghcup (Haskell)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env


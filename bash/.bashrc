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
  echo -e "\[\033[1;$1\]$2\[\033[0m\]"
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
[ -x "$(command -v nvim 2> /dev/null)" ]    && alias vim='nvim'
[ -x "$(command -v neovide 2> /dev/null)" ] && alias nvim='neovide'

# Haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# NodeJS
export npm_config_prefix="$HOME/.local" # This is where global packages are installed
export PATH="$HOME/.local/bin:$PATH"

# Nix
export PATH="$HOME/.nix-profile/bin:$PATH"

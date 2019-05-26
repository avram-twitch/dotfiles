export ZSH="/Users/atwitchell/.oh-my-zsh"

USER=``
ZSH_THEME="agnoster"
plugins=(git osx)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_files/paths  # Appends to paths local setup

eval "$(rbenv init -)" # Set up rbenv shell integration
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/Users/atwitchell/.zshrc'
bindkey '^R' history-incremental-search-backward

autoload -Uz compinit
compinit
# Aliases

## Basics
alias c="clear"
alias ls="ls -G"
alias l="ls -lh"
alias lt="ls -lht"

# zshrc
alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"

# Git
alias gs="git status"

alias ctags="`brew --prefix`/bin/ctags"
rtags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

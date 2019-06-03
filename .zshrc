# If not running interactively, don't do anything
[[ $- != *i* ]] && return

case $- in
    *i*) ;;
      *) return;;
esac

# TODO check OS for these kinds of things

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export ZSH="/home/avram/.oh-my-zsh/"
    zstyle :compinstall filename '/home/avram/.zshrc'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export ZSH="/Users/atwitchell/.oh-my-zsh"
    zstyle :compinstall filename '/Users/atwitchell/.zshrc'
else
    echo "Unknown OS"
fi

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

USER=``
ZSH_THEME="agnoster"
plugins=(git osx)

source $ZSH/oh-my-zsh.sh

# Aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

if [ -f ~/.zsh_files/paths ]; then
    source ~/.zsh_files/paths  # Appends to paths local setup
fi

eval "$(rbenv init -)" # Set up rbenv shell integration
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

bindkey -v
bindkey '^R' history-incremental-search-backward

autoload -Uz compinit
compinit
# Aliases

alias ctags="`brew --prefix`/bin/ctags"
rtags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

case $- in
    *i*) ;;
      *) return;;
esac

# Set Variables
export ZSH="$HOME/.oh-my-zsh/"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Setup ZSH Options
USER=``
# ZSH_THEME="agnoster"
if [[ ! -a $ZSH_CUSTOM/themes/powerlevel10k ]]; then
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi
ZSH_THEME=powerlevel10k/powerlevel10k
case `uname` in
    Darwin)
        # OS X
        plugins=(git osx)
        alias ls='ls -G'
    ;;
    Linux)
        plugins=(git)
        alias ls='ls --color=auto'
    ;;
esac

# Source Files
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.zsh_files/paths ] && source ~/.zsh_files/paths
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init -)" # Set up rbenv shell integration
export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"

bindkey -v
bindkey '^R' history-incremental-search-backward

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

# alias ctags="`brew --prefix`/bin/ctags"
# rtags() {
#     ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
# }

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

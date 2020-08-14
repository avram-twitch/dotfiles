# .zshrc
#
# I keep my zsh-specific stuff in here.
# Everything else should be in my .bashrc.
# That way, I can easily switch between bash
# and zsh with minimal changes to my config

# If not running interactively, don't do anything
# See https://unix.stackexchange.com/a/257613 for context
[[ $- != *i* ]] && return

case $- in
    *i*) ;;
      *) return;;
esac

# Set Variables
export ZSH="$HOME/.oh-my-zsh/"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
export P10K_PATH="$ZSH_CUSTOM/themes/powerlevel10k"

# Setup ZSH Options
if [[ ! -a $P10K_PATH ]]; then
    mkdir -p $P10k_PATH
    git clone https://github.com/romkatv/powerlevel10k.git $P10K_PATH
fi
ZSH_THEME=powerlevel10k/powerlevel10k

# Use different plugins between OS x and Linux
case `uname` in
    Darwin)
        # OS X
        plugins=(git osx)
    ;;
    Linux)
        plugins=(git)
    ;;
esac

# Source Files
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.zsh_files/paths ] && source ~/.zsh_files/paths
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Sets vim as the z-shell line editor
bindkey -v

bindkey '^R' history-incremental-search-backward

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions
source ~/.bashrc

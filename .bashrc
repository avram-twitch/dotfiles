# If not running interactively, don't do anything
# See https://unix.stackexchange.com/a/257613 for context
[[ $- != *i* ]] && return

case $- in
    *i*) ;;
      *) return;;
esac

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
# export TERM="xterm-256color"
export TERM="screen-256color"

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Options specific to mac vs linux
case `uname` in
    Darwin)
        # OS X
        alias ls='ls -G'
        alias ctags="`brew --prefix`/bin/ctags"
    ;;
    Linux)
        alias ls='ls --color=auto'
    ;;
esac

# Aliases and local functions
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.work_rc ] && source ~/.work_rc
export PATH=$PATH:/Users/avram.twitchell/non-springhealth-code/nvim-macos/bin/
export PATH=$PATH:$HOME/bin/
export PATH=$PATH:$HOME/go/bin

# Neovim 4 life
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

export NVM_DIR="$HOME/.nvm"; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export NVM_DIR="$HOME/.nvm"; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
if [ -f ~/.env_vars ]; then . ~/.env_vars; fi

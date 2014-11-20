unsetopt correct_all

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="itg-text.custom"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Disable update confirmation
DISABLE_UPDATE_PROMPT=true

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(bower brew brew-cask git git-flow gradle grunt node npm sublime symfony2 osx vagrant yeoman timuxinator)

source $ZSH/oh-my-zsh.sh

source ~/.shell/aliases
source ~/.shell/almendra
source ~/.shell/edify
source ~/.shell/paths
source ~/.shell/config
source ~/.gopen.zsh

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

__rvm_project_rvmrc

fpath=($HOME/.zsh/func $fpath)
typeset -U fpath

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

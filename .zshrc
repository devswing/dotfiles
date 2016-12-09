#          _              
#  _______| |__  _ __ ___ 
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__ 
# /___|___/_| |_|_|  \___|
#                         
#

umask 022
limit coredumpsize 0

# It is necessary for the setting of DOTPATH
if [[ -f ~/.path ]]; then
    source ~/.path
fi

# DOTPATH environment variable specifies the location of dotfiles.
# On Unix, the value is a colon-separated string. On Windows,
# it is not yet supported.
# DOTPATH must be set to run make init, make test and shell script library
# outside the standard dotfiles tree.
if [[ -z $DOTPATH ]]; then
    echo "$fg[red]cannot start ZSH, \$DOTPATH not set$reset_color" 1>&2
    return 1
fi

# Vital
# vital.sh script is most important file in this dotfiles.
# This is because it is used as installation of dotfiles chiefly and as shell
# script library vital.sh that provides most basic and important functions.
# As a matter of fact, vital.sh is a symbolic link to install, and this script
# change its behavior depending on the way to have been called.
export VITAL_PATH="$DOTPATH/etc/lib/vital.sh"
if [[ -f $VITAL_PATH ]]; then
    source "$VITAL_PATH"
fi

export ENHANCD_FILTER="fzy:$ENHANCD_FILTER"

# Exit if called from vim
[[ -n $VIMRUNTIME ]] && return

# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "$fg[red]cannot vitalize$reset_color" 1>&2
    return 1
fi

# tmux_automatically_attach attachs tmux session
# automatically when your are in zsh
$DOTPATH/bin/tmuxx

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "~/.zsh", \
    from:local, \
    nice:2

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "b4b4r07/enhancd", \
    use:init.sh

zplug "b4b4r07/peco-tmux.sh", \
    as:command, \
    use:'*.sh', \
    rename-to:'peco-tmux'

zplug "zsh-users/zsh-completions"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-syntax-highlighting", \
    nice:10

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

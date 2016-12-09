# Created by newuser for 5.2

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

zplug load 

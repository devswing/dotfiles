#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

export ZPLUG_HOME=/usr/local/opt/zplug

if [ ! -d "$ZPLUG_HOME" ];then
    # install zplug
    curl -sL zplug.sh/installer | zsh
fi

if [ ! -d "$ZPLUG_HOME" ];then
    echo "zplug: not found" >&2
    exit 1
fi

echo ${SHELL:-}
zsh

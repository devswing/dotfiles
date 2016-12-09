if [[ -z $DOTPATH ]]; then
    _get_dotpath() {
        local d
        d="${0:A:h}"
        if [[ $d =~ dotfiles$ ]]; then
            echo "$d"
        else
            return 1
        fi
    }
    export DOTPATH="$(_get_dotpath)"
    unfunction _get_dotpath
fi

export PATH=~/bin:"$PATH"

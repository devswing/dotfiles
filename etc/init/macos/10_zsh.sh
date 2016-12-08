#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/etc/lib/vital.sh

# If you don't have Z shell or don't find zsh preserved
# in a directory with the path,
# to install it after the platforms are detected
if has "zsh"; then

    # Install zsh
    if has "brew"; then
        log_echo "Install zsh with Homebrew"
        brew install zsh
    else
        log_fail "error: require: Homebrew"
        exit 1
    fi
fi

# Run the forced termination with a last exit code
exit $?

# Assign zsh as a login shell
if ! contains "${SHELL:-}" "zsh"; then
    zsh_path="$(which zsh)"

    # Check /etc/shells
    if ! grep -xq "${zsh_path:=/bin/zsh}" /etc/shells; then
        log_fail "oh, you should append '$zsh_path' to /etc/shells"
        exit 1
    fi

    if [ -x "$zsh_path" ]; then
        # Changing for a general user
        if chsh -s "$zsh_path" "${USER:-root}"; then
            log_pass "Change shell to $zsh_path for ${USER:-root} successfully"
        else
            log_fail "cannot set '$path' as \$SHELL"
            log_fail "Is '$path' described in /etc/shells?"
            log_fail "you should run 'chsh -l' now"
            exit 1
        fi

        # For root user
        if [ ${EUID:-${UID}} = 0 ]; then
            if chsh -s "$zsh_path" && :; then
                log_pass "[root] change shell to $zsh_path successfully"
            fi
        fi
    else
        log_fail "$zsh_path: invalid path"
        exit 1
    fi
fi

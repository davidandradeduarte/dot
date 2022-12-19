#!/bin/bash

# Arguments
type=${type:-full}
dir=${dir:-"$HOME/.dotfiles"}
local=${local:-false}
shell=${shell:-""}
ignore_errors=${ignore_errors:-false}

# Editable settings
DOTFILES_REMOTE_HTTPS="https://github.com/davidandradeduarte/dot.git"
DOTFILES_REMOTE_SSH="git@github.com:davidandradeduarte/dot.git"

# Constants
OS=$(uname -s)
DISTRO=$(if [ "$OS" == "Linux" ]; then cat /etc/os-release | grep "^ID=" | cut -d "=" -f 2; fi)
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

exit_cleanly() {
    set +e
    trap - EXIT
    exit $1
}

echo() {
    if [ "$1" == "-n" ]; then
        command echo -n -e "${GREEN}$2${NO_COLOR}"
    else
        command echo -e "${GREEN}$1${NO_COLOR}"
    fi
}

echor() {
    command echo -e "${RED}$1${NO_COLOR}"
}

clone() {
    if [ -d "$dir" ]; then
        remote=$(git -C "$dir" remote get-url origin 2>/dev/null)
        if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
            echo "Updating dotfiles..."
            if ! git -C "$dir" diff-index --quiet HEAD --; then
                git -C "$dir" stash
            fi
            git -C "$dir" pull
        else
            echo -n "$dir already exists. Overwrite it? [y/n] "
            read -r answer
            if [ "$answer" == "y" ]; then
                echo "Backing up old dotfiles..."
                mv "$dir" "$dir.bak"
                echo "Cloning dotfiles..."
                git clone $DOTFILES_REMOTE_HTTPS "$dir"
            fi
        fi
    else
        echo "Cloning dotfiles..."
        git clone $DOTFILES_REMOTE_HTTPS "$dir"
    fi
}

copy_local() {
    current_dir=$(dirname "$(realpath "$0")")
    if [ ! -d "$current_dir/.git" ]; then
        echor "Error: local=true is only supported when running locally and not from curl."
        exit_cleanly 1
    fi
    remote=$(git -C "$current_dir" remote get-url origin 2>/dev/null)
    if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
        echo "Copying dotfiles..."
        cp -r "$current_dir" "$dir"
    else
        echor "Error: local=true is only supported when running locally and not from curl."
        exit_cleanly 1
    fi
}

main() {
    if [ "$ignore_errors" == "false" ]; then
        set -e
        trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
        trap 'echor "\"${last_command}\" command failed with exit code $?."' EXIT
    fi

    sudo -v
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    if [ "$local" != "true" ]; then
        echo "Using remote dotfiles..."
        clone
    else
        echo "Using local dotfiles..."
        copy_local
    fi

    for file in $(find "$dir/bin/install" -name "*.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "setup.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "install.sh"); do
        . "$file"
    done

    if [ "$type" == "basic" ]; then
        basic
    elif [ "$type" == "full" ]; then
        full
    else
        echor "Error: invalid argument for type: $type. Valid arguments are: basic, full."
        exit_cleanly 1
    fi

    echo "Done! :)"

    if [ -n "$shell" ]; then
        echo "Launching $shell..."
        exec "$shell"
    fi

    exit_cleanly 0
}

main "$@"

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
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

# exitc <exit_code>
# Exits the script with the given exit code without trapping errors.
exitc() {
    set +e
    trap - EXIT
    exit $1
}

# echo_inf [-n] <message>
# Prints an info message to stdout.
echo_inf() {
    set_error_trap
    if [ "$1" == "-n" ]; then
        command echo -n -e "${GREEN}Info: ${NO_COLOR}$2"
    else
        command echo -e "${GREEN}Info: ${NO_COLOR}$1"
    fi
}

# echo_warn [-n] <message>
# Prints a warning message to stdout.
echo_warn() {
    set_error_trap
    if [ "$1" == "-n" ]; then
        command echo -n -e "${YELLOW}Warning: ${NO_COLOR}$2"
    else
        command echo -e "${YELLOW}Warning: ${NO_COLOR}$1"
    fi
}

# echo_err [-n] <message>
# Prints an error message to stdout.
echo_err() {
    set_error_trap
    if [ "$1" == "-n" ]; then
        command echo -n -e "${RED}Error: ${NO_COLOR}$2"
    else
        command echo -e "${RED}Error: ${NO_COLOR}$1"
    fi
}

# clone clones the dotfiles repository.
# If the directory already exists, it will update if it is a dotfiles repository
# or ask the user if they want to overwrite it.
# If the directory does not exist, it will clone the dotfiles repository.
clone() {
    set_error_trap
    if [ -d "$dir" ]; then
        remote=$(git -C "$dir" remote get-url origin 2>/dev/null)
        if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
            echo_inf "Updating dotfiles in ${GREEN}$dir${NO_COLOR}..."
            if ! git -C "$dir" diff-index --quiet HEAD --; then
                git -C "$dir" stash
            fi
            git -C "$dir" pull
        else
            echo_warn -n "$dir already exists. It will be backed up and overwritten."
            read -p "Continue? [y/N] " answer
            if [[ $answer == "y" ]] || [[ $answer == "Y" ]]; then
                epoch=$(date +%s)
                echo_inf "Backing up ${GREEN}$dir${NO_COLOR} to ${GREEN}$dir.bak.$epoch${NO_COLOR}"
                mv "$dir" "$dir.bak.$epoch"
                echo_inf "Cloning dotfiles..."
                git clone $DOTFILES_REMOTE_HTTPS "$dir"
            fi
        fi
    else
        echo_inf "Cloning dotfiles to ${GREEN}$dir${NO_COLOR}..."
        git clone $DOTFILES_REMOTE_HTTPS "$dir"
    fi
}

# copy_local attempts to copy the dotfiles repository from the current directory to $dir.
# this is only supported when running locally and not from curl.
copy_local() {
    set_error_trap
    current_dir=$(dirname "$(realpath "$0")")
    if [ ! -d "$current_dir/.git" ]; then
        echo_err"local=true is only supported when running locally and not from curl."
        exitc 1
    fi
    remote=$(git -C "$current_dir" remote get-url origin 2>/dev/null)
    if [[ $remote == $DOTFILES_REMOTE_HTTPS ]] || [[ $remote == $DOTFILES_REMOTE_SSH ]]; then
        if [ -d "$dir" ]; then
            epoch=$(date +%s)
            echo_inf "Backing up ${GREEN}$dir${NO_COLOR} to ${GREEN}$dir.bak.$epoch${NO_COLOR}"
            mv "$dir" "$dir.bak.$epoch"
        fi
        echo_inf "Copying dotfiles from ${GREEN}$current_dir${NO_COLOR} to ${GREEN}$dir${NO_COLOR}..."
        cp -r "$current_dir" "$dir"
    else
        echo_err"local=true is only supported when running locally and not from curl."
        exitc 1
    fi
}

# set_error_trap sets the error trap if ignore_errors is false.
set_error_trap() {
    if [ "$ignore_errors" == "false" ]; then
        set -e
        trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
        trap 'echo_err "\"${last_command}\" command failed with exit code $?."' EXIT
    fi
}

# load_scripts loads all the scripts in the bin/install and .config directories.
load_scripts() {
    set_error_trap
    for file in $(find "$dir/bin/install" -name "*.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "setup.sh"); do
        . "$file"
    done

    for file in $(find "$dir/.config" -name "install.sh"); do
        . "$file"
    done
}

# install installs the dotfiles based on the type argument.
install() {
    set_error_trap
    if [ "$type" == "basic" ]; then
        basic
    elif [ "$type" == "full" ]; then
        full
    else
        echo_err"invalid argument for type: ${RED}$type${NO_COLOR}. Valid arguments are: basic, full"
        exitc 1
    fi
}

# get_dotfiles gets the dotfiles repository
# either by cloning it or copying it from the current directory.
get_dotfiles() {
    set_error_trap
    if [ "$local" != "true" ]; then
        echo_inf "Using remote dotfiles..."
        clone
    else
        echo_inf "Using local dotfiles..."
        copy_local
    fi
}

# launch_shell launches the specified shell
launch_shell() {
    set_error_trap
    if [ -n "$shell" ]; then
        echo_inf "Launching ${GREEN}$shell${NO_COLOR}..."
        exec "$shell"
    fi
}

# enable_sudo enables sudo for the duration of the script.
enable_sudo() {
    set_error_trap
    sudo -v
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
}

# print_intro prints an intro message to stdout
# with the given arguments.
print_intro() {
    set_error_trap
    echo "---------------------------------------------"
    echo -e "${GREEN}
           __      __  _____ __         
      ____/ /___  / /_/ __(_) /__  _____
     / __  / __ \/ __/ /_/ / / _ \/ ___/
    / /_/ / /_/ / /_/ __/ / /  __(__  ) 
    \__,_/\____/\__/_/ /_/_/\___/____/  
                                    
${NO_COLOR}"
    echo "---------------------------------------------"
    echo -e "Install type: ${GREEN}$type${NO_COLOR}"
    echo -e "Install directory: ${GREEN}$dir${NO_COLOR}"
    echo -e "Shell: ${GREEN}$shell${NO_COLOR}"
    echo -e "Use current directory: ${GREEN}$local${NO_COLOR}"
    echo -e "Ignore errors: ${GREEN}$ignore_errors${NO_COLOR}"
    echo "---------------------------------------------"
}

# main is the entry point of the install script.
main() {
    set_error_trap

    enable_sudo

    print_intro

    get_dotfiles

    load_scripts

    install

    echo_inf "Done! :)"

    launch_shell

    exitc 0
}

main "$@"

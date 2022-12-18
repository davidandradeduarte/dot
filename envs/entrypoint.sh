#!/bin/bash

# Arguments
type=${type:-full}
local=${local:-false}
dir=${dir:-"$HOME/.dotfiles"}
shell=${shell:-""}

# Constants
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

echo() {
    command echo -e "${GREEN}$1${NO_COLOR}"
}

if [ "$local" == "true" ]; then
    echo "Using local dotfiles..."
    dir=$dir type=$type local="true" \
        /bin/bash /home/david/.dotfiles/install.sh
else
    echo "Using remote dotfiles..."
    type=$type \
        /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
fi

if [ $? -eq 0 ]; then
    if [ -z "$shell" ]; then
        echo "Launching $SHELL..."
        exec "$SHELL"
    else
        echo "Launching $shell..."
        exec "$shell"
    fi
fi

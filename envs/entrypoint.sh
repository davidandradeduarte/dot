#!/bin/bash

# Arguments
INSTALL_TYPE=${INSTALL_TYPE:-full}
LOCAL=${LOCAL:-false}
DOTFILES_DIR=${DOTFILES_DIR:-"$HOME/.dotfiles"}
START_SHELL=${START_SHELL:-""}

# Constants
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

echo() {
    command echo -e "${GREEN}$1${NO_COLOR}"
}

if [ "$LOCAL" == "true" ]; then
    echo "Using local dotfiles..."
    DOTFILES_DIR=$DOTFILES_DIR INSTALL_TYPE=$INSTALL_TYPE LOCAL="true" \
        /bin/bash /home/david/.dotfiles/install.sh
else
    echo "Using remote dotfiles..."
    INSTALL_TYPE=$INSTALL_TYPE \
        /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
fi

if [ $? -eq 0 ]; then
    if [ -z "$START_SHELL" ]; then
        echo "Launching $SHELL..."
        exec "$SHELL"
    else
        echo "Launching $START_SHELL..."
        exec "$START_SHELL"
    fi
fi

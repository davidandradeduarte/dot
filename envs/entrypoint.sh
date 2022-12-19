#!/bin/bash

# Arguments
type=${type:-full}
local=${local:-false}
dir=${dir:-"$HOME/.dotfiles"}
shell=${shell:-""}
ignore_errors=${ignore_errors:-false}

# Constants
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

echo_inf() {
    command echo -e "${GREEN}Info: ${NO_COLOR}$1"
}

set -e

if [ "$local" == "true" ]; then
    type=$type dir=$dir shell=$shell ignore_errors=$ignore_errors local=true
    /bin/bash /tmp/.dotfiles/install.sh
else
    type=$type dir=$dir shell=$shell ignore_errors=$ignore_errors \
        /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
fi

if [ $? -ne 0 ]; then
    exit 1
fi

if [ -z "$shell" ]; then
    echo_inf "Launching ${GREEN}$SHELL${NO_COLOR}..."
    exec $SHELL
fi

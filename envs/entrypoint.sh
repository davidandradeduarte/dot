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

echo() {
    command echo -e "${GREEN}$1${NO_COLOR}"
}

if [ "$local" == "true" ]; then
    type=$type dir=$dir shell=$shell ignore_errors=$ignore_errors local=true
    /bin/bash /tmp/.dotfiles/install.sh
else
    type=$type dir=$dir shell=$shell ignore_errors=$ignore_errors \
        /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
fi

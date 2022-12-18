# Dotfiles

## Install

```sh
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

### Options

Set the following variables to change the default behavior:

`INSTALL_TYPE` - Install type: `basic` or `full` (default: `full`)
Example:

```sh
INSTALL_TYPE=basic /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

`DOTFILES_DIR` - Dotfiles directory (default: `$HOME/.dotfiles`)
Example:

```sh
DOTFILES_DIR=$HOME/.dotfiles /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

## Test with Docker

Ubuntu:

```sh
make ubuntu
```

Fedora:

```sh
make fedora
```

### Options

_(all the previous variables are also available)_

Set the following variables to change the default behavior:

`LOCAL` - Use local dotfiles directory instead of cloning the repository: `true` or `false` (default: `false`)
Example:

```sh
make ubuntu LOCAL=true
```

`START_SHELL` - Start shell after the installation: either the binary name or full path (default: `$SHELL`)
Example:

```sh
make ubuntu START_SHELL=/bin/zsh
```

See the [Makefile](Makefile) for the available targets.

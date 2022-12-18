# Dotfiles

## Install

```sh
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

### Options

Set the following variables to change the default behavior:

`type` - Install type: `basic` or `full` (default: `full`)

<details>
  <summary>Example</summary>
  
```sh
type=basic /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

</details>

`dir` - Dotfiles directory location (default: `$HOME/.dotfiles`)

<details>
  <summary>Example</summary>
  
```sh
dir=$HOME/.dotfiles /bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

</details>

## Docker

Ubuntu:

```sh
make ubuntu
```

Fedora:

```sh
make fedora
```

See the [Makefile](Makefile) for the available targets.

### Options

_(all the previous variables are also available)_

Set the following variables to change the default behavior:

`local` - Use local dotfiles directory instead of cloning the repository: `true` or `false` (default: `false`)

<details>
  <summary>Example</summary>
  
```sh
make ubuntu local=true
```

</details>

`shell` - Startup shell after the installation: either the binary name or full path (default: `$SHELL`)

<details>
  <summary>Example</summary>
  
```sh
make ubuntu shell=/bin/zsh
```

</details>

# Dotfiles

Very straightforward dotfiles for my personal use.

No automation tools being used, just plain shell scripts and symbolic links.

Currently supported OSes: Ubuntu, Fedora, macOS.

## Install

```sh
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

### Options

| Option      | Description | Values | Default |
| ----------- | ----------- | ------ | ------- |
| `type`      | Install type | `basic` or `full` | `full` |
| `dir`       | Dotfiles directory location | Any valid path | `$HOME/.dotfiles` |
| `shell`     | Startup shell after the installation | Either the binary name or full path | Current shell |
| `local`     | Use local dotfiles directory instead of cloning the repository | `true` or `false` | `false` |
| `ignore_errors` | Ignore errors during the installation | `true` or `false` | `false` |

<details>
  <summary>Example with all options</summary>
  
```sh
type=basic \
dir=$HOME/.dotfiles \
shell=/bin/zsh \
local=true \
ignore_errors=true \
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

</details>

Default values defined in [install.sh](install.sh).

## Testing

Docker:

```sh
make ubuntu <opt=value ...>
make fedora <opt=value ...>
```

Locally:

```sh
make system <opt=value ...>
```

See the [Makefile](Makefile) for the available targets and default values.

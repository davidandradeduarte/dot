# Dotfiles

A dotfiles manager for my personal use.

No automation tools being used, just plain shell scripts and symbolic links.

Currently supported OSes: Ubuntu, Fedora, macOS.

Use at your own risk.

Table of Contents
-----------------

- [Install](#install)
- [Uninstall](#uninstall)
- [Testing](#testing)
- [License](#license)

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
| `ignore_errors` | Ignore errors during the installation | `true` or `false` | `false` |
| `local`     | Use local dotfiles directory instead of cloning the repository<br>(this option is only available when running the script locally and not from curl) | `true` or `false` | `false` |
| `no_prompt` | Skip confirmation prompts | `true` or `false` | `false` |

<details>
  <summary>Click to expand examples</summary>
  
```sh
type=basic \
dir=$HOME/.dotfiles \
shell=/bin/zsh \
local=true \
ignore_errors=true \
no_prompt=true \
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/install.sh)
```

</details>

Default values defined in [install.sh](install.sh).

## Uninstall

```sh
dir=$HOME/.dotfiles \
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/uninstall.sh)
```

This will delete all symbolic links in `$HOME/*` that point to the provided dotfiles directory and delete it afterwards.

It will not uninstall any packages, applications or OS settings that may have been added.

### Options

| Option      | Description | Values | Default |
| ----------- | ----------- | ------ | ------- |
| `dir`       | Current dotfiles directory location | Any valid dotfiles directory path | no default, mandatory |
| `no_prompt` | Skip confirmation prompt | `true` or `false` | `false` |

<details>
  <summary>Click to expand examples</summary>
  
```sh
dir=$HOME/.dotfiles \
no_prompt=true \
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/davidandradeduarte/dot/HEAD/uninstall.sh)
```

</details>

## Testing

Docker:

```sh
make ubuntu # <opt=value ...>
make fedora # <opt=value ...>
```

Locally:

```sh
make install # <opt=value ...>
```

Uninstall:

```sh
make uninstall # <opt=value ...>
```

<details>
  <summary>Click to expand examples</summary>

Docker:

```sh
make ubuntu \
  type=basic \
  dir=$HOME/.dotfiles \
  shell=/bin/zsh \
  local=true \
  ignore_errors=true \
  no_prompt=true
```

Locally:

```sh
make install \
  type=basic \
  dir=$HOME/.dotfiles \
  shell=/bin/zsh \
  local=true \
  ignore_errors=true \
  no_prompt=true \
  install_no_prompt=true
```

Uninstall:

```sh
make uninstall \
  dir=$HOME/.dotfiles \
  no_prompt=true
```

</details>

See the [Makefile](Makefile) for the available targets.

Default values defined in Dockerfiles placed in [envs](envs) directory.

## License

[MIT](LICENSE)

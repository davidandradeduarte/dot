#!/bin/sh

full_macos() {
    install_homebrew

    taps=()
    tap_brew "${taps[@]}"

    packages=(
        # Essentials
        git tmux wget curl
        # Shells
        bash zsh fish nushell powershell
        # Prompts
        starship oh-my-posh
        # Terminal Emulators
        iterm2 alacritty kitty
        # Editors
        vim neovim nano visual-studio-code rider intellij-idea
        # Browsers
        google-chrome firefox brave-browser
        # Messaging
        slack microsoft-teams discord spotify zoom
        # Languages
        go rustup-init dotnet-sdk lua
        # CLI Tools
        kubectl kubectx k9s helm terraform terragrunt azure-cli bat exa fd fzf ripgrep htop ncdu tree jq lazygit
        # Dev
        docker
        # Misc
        openvpn-connect cloudflare-warp rectangle maccy meetingbar balenaetcher caffeine bitwarden
    )
    install_brew_packages "${packages[@]}"

    # Extra
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [ ! -d "$HOME/.local/share/omf" ]; then
        echo "Installing oh-my-fish..."
        curl -L https://get.oh-my.fish | fish
    fi

    if [ ! -d "$HOME/.config/nu/plugins" ]; then
        echo "Installing oh-my-nushell..."
        nu --install oh-my-nu
    fi

    if [ ! -d "$HOME/.oh-my-posh" ]; then
        echo "Installing oh-my-posh..."
        pwsh -c "Install-Module oh-my-posh -Scope CurrentUser"
    fi

    echo "Setting up symlinks..."
    # TODO
    # sym_link "$HOME/.gitconfig" "$DOTFILES_DIR/.config/git/.gitconfig"
    # sym_link "$HOME/.tmux.conf" "$DOTFILES_DIR/.config/tmux/.tmux.conf"
    # sym_link "$HOME/.vimrc" "$DOTFILES_DIR/.config/vim/.vimrc"
    # sym_link "$HOME/.zshrc" "$DOTFILES_DIR/.config/zsh/.zshrc"
    # sym_link "$HOME/.config/fish/config.fish" "$DOTFILES_DIR/.config/fish/config.fish"
    # sym_link "$HOME/.config/nu/config.toml" "$DOTFILES_DIR/.config/nu/config.toml"
    # sym_link "$HOME/.config/starship.toml" "$DOTFILES_DIR/.config/starship.toml"
    # sym_link "$HOME/.config/omf" "$DOTFILES_DIR/.config/omf"
}

#!/bin/bash

# setup_fedora_os_settings sets up OS settings for Fedora.
setup_fedora_os_settings() {
    set_error_trap
    echo_inf "Setting up Fedora OS settings..."

    if ! grep -q max_parallel_downloads /etc/dnf/dnf.conf; then
        sudo sed -i '/\[main\]/a max_parallel_downloads=10' /etc/dnf/dnf.conf
    fi
    if ! grep -q fastestmirror /etc/dnf/dnf.conf; then
        sudo sed -i '/\[main\]/a fastestmirror=True' /etc/dnf/dnf.conf
    fi

    # sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    # sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    # sudo dnf upgrade --refresh -y
    # sudo dnf groupupdate core -y

    if gsettings list-schemas 2>/dev/null | grep -q org.gnome.desktop.interface; then
        gsettings set org.gnome.desktop.interface show-battery-percentage true
        gsettings set org.gnome.desktop.interface clock-show-date true
        gsettings set org.gnome.desktop.interface clock-show-seconds true
        gsettings set org.gnome.desktop.interface clock-show-weekday true
    else
        echo_warn "${YELLOW}gnome${NO_COLOR} not installed. Skipping ${YELLOW}gnome${NO_COLOR} settings."
    fi
}

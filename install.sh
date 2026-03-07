#!/bin/bash

PACKAGES=(
    sway
    swaybg
    swayidle
    swaylock
    waybar
    wofi
    foot
    kitty
    brightnessctl
    xdg-desktop-portal-wlr
    flameshot
    pavucontrol
    micro
    swayimg
)

# Configuration folders to move
CONFIG_FOLDERS=(
    cava
    dunst
    fastfetch
    flameshot
    foot
    kitty
    sway
    waybar
    wofi
)

echo "Starting Sway dotfiles installation for Ubuntu/Mint...."

# 1. Update package list
echo "[+] Updating package list..."
sudo apt update

# 2. Check for fastfetch (might need PPA on older Ubuntu/Mint)
if ! apt-cache show fastfetch > /dev/null 2>&1; then
    echo "[!] fastfetch not found in the main repository. Adding PPA..."
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update
fi

# 3. Install utilities
echo "[+] Installing utilities..."
sudo apt install -y "${PACKAGES[@]}" fastfetch

# 4. Add user to video group for brightnessctl
echo "[+] Adding user $USER to the 'video' group for brightnessctl..."
sudo usermod -aG video "$USER"

# 5. Move configuration folders
echo "[+] Moving configuration folders to ~/.config/..."
mkdir -p "$HOME/.config"

for folder in "${CONFIG_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        if [ -d "$HOME/.config/$folder" ]; then
            echo "    - Backing up existing ~/.config/$folder to ~/.config/${folder}.bak"
            rm -rf "$HOME/.config/${folder}.bak"
            mv "$HOME/.config/$folder" "$HOME/.config/${folder}.bak"
        fi
        echo "    - Copying $folder to ~/.config/"
        cp -r "$folder" "$HOME/.config/"
    else
        echo "[!] Warning: Folder '$folder' not found in the current directory."
    fi
done

echo "Installation Complete!"
echo "Please log out and log back in to take effect."
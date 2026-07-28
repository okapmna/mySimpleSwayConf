#!/bin/bash

set -e

# ============================================================
# DISTRO DETECTION
# ============================================================
detect_distro() {
    if command -v apt &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    else
        echo "unsupported"
    fi
}

PKG_MGR=$(detect_distro)
echo "Detected package manager: $PKG_MGR"

if [ "$PKG_MGR" = "unsupported" ]; then
    echo "Unsupported distribution. Please install packages manually."
    exit 1
fi

# ============================================================
# PACKAGE DEFINITIONS
# ============================================================
# Core Sway & Wayland
PKG_CORE="sway swaybg swayidle swaylock waybar wofi xdg-desktop-portal-wlr"

# Terminal emulators (choose one)
PKG_TERM="foot kitty"

# Utilities
PKG_UTIL="brightnessctl flameshot pavucontrol micro swayimg fastfetch dmenu wmenu"

# Theme dependencies
PKG_THEME=""

# Combine all
PACKAGES="$PKG_CORE $PKG_TERM $PKG_UTIL"

# Distro-specific adjustments
case "$PKG_MGR" in
    apt)
        INSTALL_CMD="sudo apt update && sudo apt install -y"
        REMOVE_CMD="sudo apt remove -y"

        if ! apt-cache show fastfetch &>/dev/null; then
            echo "[!] fastfetch not found in main repo. Adding PPA..."
            sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
            sudo apt update
        fi

        USER_GROUPS_CMD="sudo usermod -aG video \"$USER\""
        PORTAL_PATH="/usr/libexec"
        POLKIT_PATH="/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
        ;;

    dnf)
        INSTALL_CMD="sudo dnf install -y"
        REMOVE_CMD="sudo dnf remove -y"

        if ! rpm -q fastfetch &>/dev/null 2>&1; then
            echo "[!] fastfetch not found. Enabling COPR..."
            sudo dnf copr enable -y zhangsongcui/fastfetch
        fi

        USER_GROUPS_CMD="sudo usermod -aG video \"$USER\""
        PORTAL_PATH="/usr/libexec"
        POLKIT_PATH="/usr/libexec/polkit-gnome-authentication-agent-1"
        ;;

    pacman)
        INSTALL_CMD="sudo pacman -S --needed --noconfirm"
        REMOVE_CMD="sudo pacman -Rns --noconfirm"

        USER_GROUPS_CMD="sudo usermod -aG video \"$USER\""
        PORTAL_PATH="/usr/lib"
        POLKIT_PATH="/usr/lib/polkit-gnome-authentication-agent-1"
        ;;
esac

# ============================================================
# CONFIG FOLDERS
# ============================================================
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

# ============================================================
# INSTALLATION
# ============================================================
echo ""
echo "=============================================="
echo "  Sway Dotfiles Installer"
echo "  Package manager: $PKG_MGR"
echo "=============================================="
echo ""

# 1. Install packages
echo "[+] Installing packages..."
eval "$INSTALL_CMD $PACKAGES"

# 2. Add user to video group for brightnessctl
echo "[+] Adding user to 'video' group..."
eval "$USER_GROUPS_CMD"

# 3. Create portal/polkit symlinks if needed (Arch)
if [ "$PKG_MGR" = "pacman" ]; then
    if [ ! -f "/usr/libexec/xdg-desktop-portal-wlr" ] && [ -f "/usr/lib/xdg-desktop-portal-wlr" ]; then
        echo "[+] Creating /usr/libexec symlinks for portal compatibility..."
        sudo mkdir -p /usr/libexec
        sudo ln -sf /usr/lib/xdg-desktop-portal-wlr /usr/libexec/xdg-desktop-portal-wlr
        sudo ln -sf /usr/lib/xdg-desktop-portal /usr/libexec/xdg-desktop-portal
    fi
fi

# 4. Copy configuration folders
echo "[+] Copying configuration folders to ~/.config/..."
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

# 5. Make scripts executable
echo "[+] Making scripts executable..."
chmod +x "$HOME/.config/sway/scripts/"*.sh 2>/dev/null || true
chmod +x "$HOME/.config/wofi/"*.sh 2>/dev/null || true

# 6. Update flameshot path to current user
if [ -f "$HOME/.config/flameshot/flameshot.ini" ]; then
    sed -i "s|savePath=.*|savePath=$HOME/Pictures/screenshots|" "$HOME/.config/flameshot/flameshot.ini"
fi

echo ""
echo "=============================================="
echo "  Installation Complete!"
echo "=============================================="
echo ""
echo "Please log out and log back in for all changes to take effect."
echo ""
echo "Post-install tips:"
echo "  - Install themes: Orchis-Dark-Compact, Tela-dark, Papirus-Dark"
echo "  - Install fonts: JetBrainsMono Nerd Font"
echo "  - Configure GTK: gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark-Compact'"
echo "  - Configure GTK: gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'"

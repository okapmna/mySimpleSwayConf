# My Simple Sway Config

A collection of my personal dotfiles for a minimalist, and functional Sway setup.

## Preview

- **Window Manager**: `Sway` (A tiling window manager for Wayland)
- **Status Bar**: `Waybar`
- **Launcher**: `Wofi`
- **Terminal**: `Foot` & `Kitty`
- **Theme**: `Catppuccin Mocha`

## Components & Dependencies

The following packages are required for this setup to work correctly.

### 1. Core System
  - `sway` | The main compositor and window manager.
  - `swaybg` | Utility for setting wallpapers.
  - `swayidle` | Daemon for idle management (e.g., screen locking).
  - `swaylock` | Screen locker.
  - `waybar` | A highly customizable status bar.
  - `wofi` | Application launcher.
  - `xdg-desktop-portal-wlr` | Required for screen sharing and other portal features.

### 2. Applications & Utilities
  - `foot` | A lightweight terminal emulator for Wayland.
  - `kitty` | A feature-rich, GPU-accelerated terminal emulator.
  - `brightnessctl` | Controls screen brightness.
  - `fastfetch` | A tool for displaying system information.
  - `flameshot` | Screenshot utility.
  - `micro` | A modern and easy-to-use terminal text editor.
  - `swayimg` | A simple image viewer for Sway.

### 3. Theme & Appearance
- **Fonts** | `JetBrains Mono Nerd Font`
- **GTK** | `Orchis-Dark-Compact`
- **Icons** | `Tela-dark`
- **Colors** | `Catppuccin Mocha`

## Installation

```bash
git clone https://github.com/okapmna/mySimpleSwayConf.git
cd mySimpleSwayConf
chmod +x install.sh
./install.sh
```

The install script will automatically detect your distribution and install packages using the appropriate package manager.

## Manual Package Installation

If you prefer to install packages manually:

**Ubuntu/Debian/Mint:**
```bash
sudo apt install sway swaybg swayidle swaylock waybar wofi foot kitty brightnessctl xdg-desktop-portal-wlr flameshot fastfetch pavucontrol micro swayimg dmenu wmenu
```

**Fedora:**
```bash
sudo dnf install sway swaybg swayidle swaylock waybar wofi foot kitty brightnessctl xdg-desktop-portal-wlr flameshot fastfetch pavucontrol micro swayimg dmenu wmenu
```

**Arch:**
```bash
sudo pacman -S sway swaybg swayidle swaylock waybar wofi foot kitty brightnessctl xdg-desktop-portal-wlr flameshot fastfetch pavucontrol micro swayimg dmenu wmenu
```

Additional themes (install manually):
```bash
ttf-jetbrains-mono-nerd orchis-gtk-theme tela-icon-theme papirus-icon-theme
```

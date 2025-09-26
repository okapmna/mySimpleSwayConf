# My Simple Sway Config



A collection of my personal dotfiles for a minimalist, and functional Sway setup. This repository is named `mySimpleSwayConf`.

## Preview

- **Window Manager**: `Sway` (A tiling window manager for Wayland)

- **Status Bar**: `Waybar`

- **Launcher**: `Wofi`

- **Terminal**: `Foot` & `Kitty`

- **Theme**: `Catppuccin Mocha`



---



## Components & Dependencies



The following packages are required for this setup to work correctly.



### 1. Core System



These packages form the foundation of the desktop environment.



| Package | Description |

| ------------------------ | ------------------------------------------------------ |

| `sway` | The main compositor and window manager. |

| `sway-backgrounds` | Utility for setting wallpapers. |

| `swayidle` | Daemon for idle management (e.g., screen locking). |

| `swaylock` | Screen locker. |

| `waybar` | A highly customizable status bar. |

| `wofi` | Application launcher. |

| `xdg-desktop-portal-wlr` | Required for screen sharing and other portal features. |



### 2. Applications & Utilities

  `foot` | A lightweight terminal emulator for Wayland.
  `kitty` | A feature-rich, GPU-accelerated terminal emulator.
  `brightnessctl` | Controls screen brightness. 
  `fastfetch` | A tool for displaying system information. 
  `flameshot` | Screenshot utility. 
  `micro` | Modern and easy-to-use terminal text editor. 
  `swayimg` | Simple image viewer for Sway. 



### 3. Theme & Appearance

**Fonts** | `JetBrains Mono Nerd Font` 
**GTK** | `Orchis-Dark-Compact` 
**Icons** | `Tela-dark` 
**Colors scheme** | `Catppuccin Mocha`



## Installation

1. **Install All Packages**

Use your distribution's package manager to install all the required dependencies.

sway swaybg swayidle swaylock waybar wofi foot kitty

brightnessctl xdg-desktop-portal-wlr flameshot fastfetch neovim micro swayimg

ttf-jetbrains-mono-nerd orchis-gtk-theme-git tela-icon-theme-git


3. **Run install.sh**
### 1. Clone this repository
```bash
git clone https://github.com/YOUR-USERNAME/mySimpleSwayConf.git
```
### 2. Navigate into the directory
```bash
cd mySimpleSwayConf
```
### 3. Make the script executable
```bash
chmod +x install.sh
```
### 4. Run the installation script
```bash
./install.sh
```




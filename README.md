### Basic setup
---

Install following packages:

* stow
* fastfetch
* neovim
* bash-completion
* jq

### Create required directories

```
mkdir -p ~/.config/nvim
mkdir ~/.vim
mkdir -p ~/.local/bin 
mkdir -p ~/.local/share
mkdir ~/screenshots
mkdir ~/wallpapers
mkdir ~/downloads
```

### Sway
---

#### Prerequesites

Install required packages:

* nmcli
* bluetoothctl
* pipewire
* pipewire-pulse
* pipewire-alsa
* xdg-desktop-portal
* xdg-desktop-portal-wlr
* dunst
* rofi
* alacritty

#### Setup dotfiles symlinks

```
cd ~/dotfiles
stow dunst
stow rofi
stow alacritty
stow sway
```

#### Setup local configuration

The default sway configuration can be overwritten or extended by \*.local files,
placed under `~/.config/sway/config.d` directory.
They can be used for set custom wallpaper, different output configuration, etc.

#### Starting sway without login manager (from TTY)

In order to run sway with audio/video capabilities it has to be run with dbus-run-session manually
There is a script under `~/.local/bin/start-sway` that provides this requirement.
Additionaly, the script exports some environemnt variables for xdg desktop portal.
Remember to add the user to audio, video and bluetooth groups.

#### Screen sharing on Sway

1. Add xdg-desktop-portal-* to sway's autostart (ex. ~/.config/sway/config.d/autostart.local):

```
exec sh -c "pkill -f xdg-desktop-portal || true"
exec sh -c "pkill -f xdg-desktop-portal-wlr || true"

exec sh -c "dbus-update-activation-environment --all"
exec sh -c "/usr/libexec/xdg-desktop-portal-wlr; sleep 1"
exec sh -c "/usr/libexec/xdg-desktop-portal"
```


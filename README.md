### Prerequesites

Install following packages:

* stow
* nmcli
* bluetoothcli
* dunst
* fastfetch
* rofi
* alacritty
* neovim
* bash-completion
* jq

### Usage

```
# bootstrap
mkdir ~/.config
mkdir ~/.config/nvim
mkdir ~/.vim
mkdir -p ~/.local/bin 
mkdir -p ~/.local/share
mkdir ~/screenshots
mkdir ~/wallpapers
mkdir ~/downloads

cd ~/dotfiles

# create symlinks
stow bash
stow vim
```

### Sway

Make sure the `~/.local/bin` directory is created.
You can put your local configuration extensions under `dotfiles/sway/.config/sway/config.d/*.local`.


```
cd dotfiles
stow sway
start-sway
```

### Screen sharing on Sway

1. Make sure the following packages are installed:
    * xdg-desktop-portal-wlr
    * xdg-desktop-portal
1. Add xdg-desktop-portal-* to sway's autostart (ex. ~/.config/sway/config.d/autostart.local):

```
exec sh -c "pkill -f xdg-desktop-portal || true"
exec sh -c "pkill -f xdg-desktop-portal-wlr || true"

exec sh -c "dbus-update-activation-environment --all"
exec sh -c "/usr/libexec/xdg-desktop-portal-wlr; sleep 1"
exec sh -c "/usr/libexec/xdg-desktop-portal"
```


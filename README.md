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

### Usage

```
# bootstrap
mkdir ~/.config
mkdir ~/.config/nvim
mkdir ~/.vim
mkdir -p ~/.local/bin 
mkdir ~/screenshots
mkdir ~/wallpapers
mkdir ~/downloads

cd ~/dotfiles

# create symlinks
stow bash
stow vim
```

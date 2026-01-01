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

* dbus
* sway
* swaylock
* swayidle
* brightnessctl
* grim
* slurp
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
* elogind (in case of a distro without systemd)
* fonts: Mononoki, Cantarell
* wl-clipboard

#### Setup d-bus

On systemd or DE based distributions there is probably nothing to do here.
Otherwise you need to make sure that dbus runs as a init system service.
Sway should be started by `dbus-run-session sway` in order to work with pipewire.

#### Setup dotfiles symlinks

```
cd ~/dotfiles
stow dunst
stow rofi
stow alacritty
stow sway
stow swaynag
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
exec pkill -f xdg-desktop-portal
exec pkill -f xdg-desktop-portal-wlr

exec dbus-update-activation-environment --all
exec /usr/libexec/xdg-desktop-portal-wlr
exec /usr/libexec/xdg-desktop-portal
```

2. Install wlroots

#### Packages to update count on Void linux

The swaybar reads `/tmp/pkgs-updates-count` file in order to determine whether to display an indicator.
For swaybar to work with this, some populating mechanism must be provided.
In Void linux one can run a local user's service by `runsvdir` utility.
Remember to run it with sway startup, for example `exec sh -c "runsvdir ~/service"`.

Example service could be something like that:

```
#!/bin/env bash

while :; do
    count=$(xbps-install --memory-sync --dry-run --update 2>/dev/null | grep -E 'update|install' | wc -l)
    echo "$count" > /tmp/pkgs-updates-count
    sleep 3600
done
```

### File management
---

#### Prerequesites

Install useful packages

* vifm - file manager with VIM motions
* imv - image preview
* mpv - video player
* zathura - PDF viewer with VIM motions (zathura-pdf-poppler)

#### Setup dotfiles symlinks

```
cd ~/dotfiles
stow vifm
```

### Audio
---

* Install packages:
    * pipewire
    * alsa-pipewire
    * alsa-lib
    * libspa-alsa
    * libspa-bluetooth
* Follow the distribution's pipewire setup
* Remember to add `exec pipewire` to your autostart in sway (in case you use it)

### Adwaita Theme
---

* Install packages:
    * adwaita-fonts
    * adwaita-icon-theme
    * adwaita-plus (optionally)
* `sudo ln -s /usr/share/icons/Adwaita /usr/share/icons/defauls

### Printing (HP Printer)
---

1. Install required packages
    * cups
    * cups-filters
    * hplip
    * ipptool
    * dbus
1. Add user to groups `lp` and `lpadmin`
1. Perform printer setup, for example in CUPS at http://localhost:631

#### Printer job notifications

With the above setup there will be no notifications about printig jobs.
There are at least two solutions to this:

1. Install hplip-gui and run hp-systray
    * QT dependent piece of software
    * Ugly UI
    * Tray icon out of style
    * Very easy setup
1. Configure custom scripts
    * Harder way
    * Very customizable

##### Custom notifications setup

> TODO: This is work in progress.
It should be a part of some MCD (my custom desktop) installation

1. Make sure the user is a member of group `lp`
1. Add printer dbus subscriptions:

    ```
    ipptool -tv -d recipient=dbus:// ipp://localhost ./create-printer-subscription
    ```

    `create-printer-subscription` file is a plain text with IPP request content like:

    ```
    {
        NAME "Create a push printer subscription"
        OPERATION Create-Printer-Subscription

        GROUP operation-attributes-tag
        ATTR charset attributes-charset utf-8
        ATTR language attributes-natural-language en
        ATTR uri printer-uri $uri

        GROUP subscription-attributes-tag
        ATTR uri notify-recipient-uri $recipient
        ATTR keyword notify-events job-state-changed
        ATTR integer notify-lease-duration 0
    }
    ```

    Place it somewhere in your system.
    It will create a printer subscription with no expiration date.
    The notifications will be pushed into dbus under 'com.cups.cupsd.Notifier' interface

1. Cupsd notifier sends events onto system dbus, so there is a need to add an allowing policy.
    Create a `/etc/dbus-1/system.d/cups-notifier.conf` file with content:

    ```
    <!-- This configuration file specifies the required security policies
         for cupsd notification daemon to work. -->

    <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
    <busconfig>
      <policy group="lp">
        <allow receive_interface="org.cups.cupsd.Notifier"/>
      </policy>
    </busconfig>
    ```

1. Run custom runit service
1. Cancel subscription
    There is a way to cancel the printer subscription

    ```
    ipptool -tv ipp://localhost ./cancel-printer-subscription.test
    ```

    `cancel-printer-subscription.test` file is a plain text with IPP request content like:

    ```
    {
        NAME "Cancel subscription by ID"
        OPERATION Cancel-Subscription

        GROUP operation-attributes-tag
        ATTR charset attributes-charset utf-8
        ATTR language attributes-natural-language en
        ATTR uri printer-uri $uri
        ATTR integer notify-subscription-id 5
    }
    ```

### Useful packages
---

* guvcview - camera capture
* vmfm - file manager
* wf-recorder - screen recorder
* pandoc - markdown converter
* udisks2 - mounting flash drives as user

# Basic setup

## Required packages:

* stow
* fastfetch
* neovim
* bash-completion
* jq

## Setup

```
mkdir -p ~/.config/nvim
mkdir ~/.vim
mkdir -p ~/.local/bin 
mkdir -p ~/.local/share
mkdir ~/screenshots
mkdir ~/wallpapers
mkdir ~/downloads
```

## Setup bash

Bash setup the basic profile, prompt theme and adds `~/.local/bin` to `PATH` variable

```
stow bash
```

# Sway Base

## Required packages

* dbus
* alacritty
* rofi
* font-noto-sans
* swaylock
* swaynag
* swayidle
* elogind (or seatd?, confirm that)
* wl-clipboard

## Setup

Sway base contains very basic sway configuration with just general keybindigs.
It composes configuration from ~/.config/sway/config.d/* files so feel free to add your local config.
Autostart scripts would be probably the most popular use case

> When adding your own config files into `~/.config/sway/config.d/` directory be aware this is
a symlink unless you stow other sway modules.
Adding your own config files will add them in this case to the dotfiles repository directory.
If you want to prevent this behaviour,
either add another sway module or create directory `~/.config/sway/config/d` first,
before stow the sway-base.

Sway base module provides also a `start-sway` bash script.
It is dedicated for users who don't use any other DE, nor graphical login managers.
If this is your case log in into TTY and run `start-sway`

```
# Required unless you plan to use other stow modules from this dotfiles
mkdir -p ~/.config/sway/config.d
stow sway-base
echo "output * bg /path/to/your/wallpaper fill" >> ~/.config/sway/config.d/90-wallpaper
```

# Sway Notifications

## Required packages

* dunst

## Setup

```
stow sway-dunst
stow dunst
```

# Sway Media

## Required packages:

* grim
* slurp
* pipewire
* pipewire-pulse
* pipewire-alsa
* alsa-lib
* libspa-alsa
* libspa-bluetooth
* brightnessctl

> Setup pipewire according to your distro manual.
Package names could also be different.

## Setup

```
stow sway-media-pipewire
```

# Sway screen sharing

## Required packages

* xdg-desktop-portal
* xdg-desktop-portal-wlr
* wlroots

## Setup

> Note that if you already use some other desktop environment,
the xdg portal may be already installed with proper packages.
This setup is dedicated for standalone sway installation.

```
stow sway-xdg-portal
```

# Packages to update count on Void linux

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

# File management

## Required packages

* vifm - file manager with VIM motions
* imv - image preview
* mpv - video player
* zathura - PDF viewer with VIM motions (zathura-pdf-poppler)

## Setup dotfiles symlinks

```
stow vifm
```

# Adwaita Theme

## Required packages:

* adwaita-fonts
* adwaita-icon-theme
* adwaita-plus (optionally)

## Setup

`sudo ln -s /usr/share/icons/Adwaita /usr/share/icons/default`

# Printing (HP Printer)

## Required packages

* cups
* cups-filters
* hplip
* ipptool
* dbus

## Setup

1. Add user to groups `lp` and `lpadmin`
1. Perform printer setup, for example in CUPS at http://localhost:631

## Printer job notifications

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

### Custom notifications setup

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

* guvcview - camera capture
* wf-recorder - screen recorder
* pandoc - markdown converter
* udisks2 - mounting flash drives as user

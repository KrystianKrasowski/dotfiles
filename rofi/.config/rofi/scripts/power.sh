#!/usr/bin/env bash

# check dependencies
if ! command -v loginctl >/dev/null 2>&1; then
    echo "loginctl util is required"
    exit 1
fi

if [ x"$@" = x"reboot" ]; then
    loginctl reboot
    exit 0
fi

if [ x"$@" = x"shutdown" ]; then
    loginctl poweroff
    exit 0
fi

echo -en "\0prompt\x1fPower\n"
echo -en "reboot\0display\x1f󰜉\tReboot\x1fmeta\x1freboot\n"
echo -en "shutdown\0display\x1f󰤆\tShutdown\x1fmeta\x1fshutdown\x1fmeta\x1fpoweroff"


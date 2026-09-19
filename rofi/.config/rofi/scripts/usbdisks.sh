#!/usr/bin/env bash

format() {
    while IFS=, read -r path group uuid label mountpoint; do
        name="$uuid"
        if [ -n "$label" ]; then
            name="$label"
        fi

        display=""
        if [ -n "$mountpoint" ]; then
            display="󰋊\t󰚥\t$name ($mountpoint)"
        else
            display="󰋊\t󰚦\t$name"
        fi

        echo -en "$path,$mountpoint,$name\0display\x1f$display\n"
    done
}

APP_NAME="usbdisks"

if [ -n "$1" ]; then
    path=$(echo "$1" | cut -d , -f1)
    mountpoint=$(echo "$1" | cut -d , -f2)
    label=$(echo "$1" | cut -d , -f3)

    # check if path exists
    ls $path &>/dev/null
    if [ "$?" -gt 0 ]; then
        exit 1
    fi

    message=""
    if [ -z "$mountpoint" ]; then
        message=$(udisksctl mount -b "$path")
        notify-send -u low -a "$APP_NAME" "$label" "$message"
    else
        message=$(udisksctl unmount -b "$path")
        notify-send -u low -a "$APP_NAME" "$label" "$message"
    fi

    exit 0
fi

echo -en "\0prompt\x1fDisk:\n"
echo -en "\0message\x1fMount or unmount an USB drive\n"
echo -en "\0no-custom\x1ftrue\n"

lsblk -J -O \
    | jq -r '.blockdevices[].children[] | select(.group == "disk" and .rm == true) | [.path,.group,.uuid,.label,.mountpoint] | @csv' \
    | sed 's/"//g' \
    | format


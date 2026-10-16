#!/usr/bin/env bash

# Check dependencies
if ! command -v nmcli >/dev/null; then
    echo "Network manager is not installed."
    exit 1
fi

if ! command -v wifi-nm-connect >/dev/null; then
    echo "wifi-nm-connect script is not installed."
    exit 1
fi

if [ -n "$ROFI_INFO" ]; then
    IFS=':' read -r ssid secured <<< "$ROFI_INFO"
    coproc ( wifi-nm-connect "$ssid" "$secured" > /dev/null 2>&1 )
    exit 0
fi

icon() {
    local icon_set_unsecured="󰤯 󰤯 󰤟 󰤟 󰤢 󰤢 󰤥 󰤥 󰤨 󰤨"
    local icon_set_secured="󱛏 󱛏 󰤡 󰤡 󰤤 󰤤 󰤧 󰤧 󰤪 󰤪"
    local icon_set=
    local icon=""

    if [ -z "$2" ]; then
        read -r -a icon_set <<< "$icon_set_unsecured"
    else
        read -r -a icon_set <<< "$icon_set_secured"
    fi

    for i in "${!icon_set[@]}"; do
        local ind=$((($i + 1) * 10))
        if [ "$1" -le $ind ]; then
            icon="${icon_set[$i]}"
            break
        fi
    done

    echo -ne "$icon"
}

build_wifi_menu() {
    local list=""

    while IFS=: read -r in_use ssid signal secured; do
        if [ "$ssid" = "$2" ] || [ -z "$ssid" ]; then
            continue
        fi

        list="$list$(icon $signal $secured)\t$ssid\0info\x1f$ssid:$secured\n"
    done <<< "$1"

    echo -e "$list"
}

if ! command -v nmcli >/dev/null; then
    echo "Network manager is not installed."
    exit 1
fi

# Build SSIDs menu
wifis=$(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list)
connected=$(echo "$wifis" | grep -i '*' | cut -d ':' -f 2)

echo -ne "\0prompt\x1fSSID\n"
echo -ne "\0message\x1fConnected: $connected\n"

build_wifi_menu "$wifis" "$connected"

exit 0

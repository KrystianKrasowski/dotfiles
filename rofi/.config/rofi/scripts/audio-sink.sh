#!/usr/bin/env bash

# check dependencies
if ! command -v pw-dump >/dev/null 2>&1; then
    echo "pipewire util is required"
    exit 1
fi

if ! command -v wpctl >/dev/null 2>&1; then
    echo "wireplumber util is required"
    exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "jq util is required"
    exit 1
fi

format() {
    while read -r line; do
        local sink_id=$(echo "$line" | cut -d ',' -f 1)
        local nick=$(echo "$line" | cut -d ',' -f 2)

        if [ -z "$nick" ]; then
            nick=$(echo "$line" | cut -d ',' -f 3)
        fi

        local display_value="\t$nick"

        echo -en "$sink_id\0display\x1f$display_value\x1fmeta\x1f$nick\n"
    done
}

if [ -n "$1" ]; then
    wpctl set-default "$1"
    exit 0
fi

echo -en "\0prompt\x1fAudio sink\n"

pw-dump \
    | jq -r '.[] | select(.info.props["media.class"] == "Audio/Sink") | [.id, .info.props["node.nick"]] | @csv' \
    | sed 's/"//g' \
    | format

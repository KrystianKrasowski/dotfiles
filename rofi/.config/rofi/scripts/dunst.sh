#!/usr/bin/env bash

DELIM="%"

format() {
    local message=""

    while IFS=% read -r line; do
        while IFS=, read -r id urgency app summary body; do
            if [ "$urgency" = "NORMAL" ]; then
                echo -n "$id\0display\x1f<span>$summary</span>\n<small>$body</small>$DELIM"
            elif [ "$urgency" = "CRITICAL" ]; then
                echo -n "$id\0display\x1f<span>$summary</span>\n<small>$body</small>\x1furgent\x1ftrue$DELIM"
            fi
        done <<< "$line"
    done
}

if [ -n "$1" ]; then
    dunstctl history-rm "$1"
fi

notifications=$(
    dunstctl history \
        | jq -rc '.data[][] | [.id.data, .urgency.data, .appname.data, .summary.data, .body.data] | @csv' \
        | sed -r 's/(\\"|")//g' \
        | format
)

if [[ $ROFI_RETV -eq 0 ]]; then
    echo -en "\0delim\x1f$DELIM\n"
fi

echo -en "\0prompt\x1fNotification:$DELIM"
echo -en "\0markup-rows\x1ftrue$DELIM"
echo -en "$notifications"


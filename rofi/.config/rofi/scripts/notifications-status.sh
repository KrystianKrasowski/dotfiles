#!/usr/bin/env bash

# check dependencies
if ! command -v dunstctl >/dev/null 2>&1; then
    echo "dunstctl util is required"
    exit 1
fi

paused=$(dunstctl is-paused)

if [ x"$@" = x"pause" ]; then
    dunstctl set-paused true
    exit 0
fi

if [ x"$@" = x"resume" ]; then
    dunstctl set-paused false
    exit 0
fi

echo -en "\0prompt\x1fStatus\n"

if [ "$paused" = "false" ]; then
    echo -en "pause\0display\x1f\t Pause\n"
else
    echo -en "resume\0display\x1f\t Resume\n"
fi

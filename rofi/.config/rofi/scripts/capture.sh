#!/usr/bin/env bash

CAPTURES_DIR="$HOME/screenshots"

make_screenshot() {
    local screenshot_file="$CAPTURES_DIR/screenshot_$(date +%Y-%m-%d_%H-%m-%s).png"
    grim -t png -g "$(slurp)" "$screenshot_file"
    if [ "$?" -eq 0 ]; then
        notify-send "Screenshot created" "Screenshot is stored in $screenshot_file" -a "Capture" -u low
    fi
}

capture_screen() {
    local capture_file="$CAPTURES_DIR/capture_$(date +%Y-%m-%d_%H-%m-%s).mp4"
    wf-recorder -g "$(slurp)" -f "$capture_file"
    if [ "$?" -eq 0 ]; then
        notify-send "Screen captured" "Screen capture is stored in $capture_file" -a "Capture" -u low
    fi
}

if [ ! -d "$CAPTURES_DIR" ]; then
    mkdir "$CAPTURES_DIR"
fi

if [ x"$@" = x"screenshot" ]; then
    coproc (make_screenshot > /dev/null 2>&1)
    exit 0
fi

if [ x"$@" = x"capture" ]; then
    coproc (capture_screen > /dev/null 2>&1)
    exit 0
fi

echo -ne '\0prompt\x1fCapture:\n'
echo -ne 'screenshot\0display\x1f󰄀\tMake screenshot\n'
echo -ne 'capture\0display\x1f\tCapture screen\n'

#!/usr/bin/env bash

if [ -n "$1" ]; then
    $($1 --exec)
    exit 0
fi

project_scripts="$HOME/.local/lib/dev-projects.d"

if [ ! -d "$project_scripts" ]; then
    echo -en "No project scripts set up in: $project_scripts"
    exit 1
fi

echo -en "\0prompt\x1fDev projects\n"
for project in "$project_scripts/"*; do
    read -r icon name <<< $($project --describe)
    echo -en "$project\0display\x1f$icon\t$name\n"
done


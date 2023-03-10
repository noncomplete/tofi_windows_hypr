#!/bin/bash
#
# Author: Mostopha Labib <noncomplete>
# License: MIT

set -e
set -u

selection=$(hyprctl clients -j | jq -r '.[] | .workspace.id, .title, .class, .address' | awk '{printf "%s <=> ", $0; getline; printf "%s ", $0; getline; printf "[%s] ", $0; getline; printf " (%s)\n", $0}' | tofi --prompt-text="Windows:")

address=$(echo "$selection" | grep -E -o '\(0x.*\)' | sed 's/[()]//g')

hyprctl dispatch focuswindow address:$address

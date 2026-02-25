#!/bin/bash
# Check if the active window is part of a group
if [[ $(hyprctl activewindow -j | jq -r ".grouped | length") -gt 0 ]]; then
    # If in a group, cycle to the next tab
    hyprctl dispatch changegroupactive f
else
    # If not in a group, cycle to the next window/group
    hyprctl dispatch cyclenext
    hyprctl dispatch bringactivetotop
fi
#!/bin/bash

# This script will randomly select a wallpaper from a directory
# and set it using hyprpaper. It will then sleep for a specified time.

# YOUR MONITOR NAME
MONITOR="HDMI-A-1"

# THE DIRECTORY WHERE YOUR WALLPAPERS ARE LOCATED
# Use a full path to avoid issues.
WALLPAPER_DIR="/home/neo/Images/Backgrounds/Linux"

# THE TIME TO WAIT BETWEEN WALLPAPER CHANGES (in seconds)
# 1800s = 30 minutes
# 3600s = 1 hour
SLEEP_SECONDS=600

# --- SCRIPT LOGIC ---
while true; do
    # Find all image files in the directory
    # -iname is case-insensitive, which is good.
    # shuf -n 1 picks one random line.
    RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

    # Ensure a picture was found
    if [ -z "$RANDOM_PIC" ]; then
        echo "No images found in $WALLPAPER_DIR. Exiting."
        exit 1
    fi

    # Use hyprctl to change the wallpaper.
    # First, preload the image for a smoother transition.
    hyprctl hyprpaper preload "$RANDOM_PIC"
    
    # Then, set it as the wallpaper.
    hyprctl hyprpaper wallpaper "$MONITOR,$RANDOM_PIC"

    # Wait for the specified amount of time before changing again.
    sleep $SLEEP_SECONDS
done

#!/bin/bash

# Our main screen is always DP-4 with this resolution
main_screen="DP-4"
main_screen_resolution="2560x1600"

# Get the list of connected screens excluding the main screen
secondary_screens=$(xrandr --query | grep " connected" | grep -v "$main_screen" | cut -d" " -f1)

# Select the first available secondary screen
secondary_screen=$(echo "$secondary_screens" | head -n 1)

if [ -z "$secondary_screen" ]; then
    echo "No secondary screen found."
else
# Configure the secondary screen
# --output "$secondary_screen": This flag specifies which display output you're configuring. $secondary_screen is a placeholder that will be replaced by the name of the secondary screen (e.g., HDMI-0, VGA-1) determined by the script.

# --scale-from "$main_screen_resolution": This option scales the content from the specified resolution ($main_screen_resolution) to the native resolution of the secondary screen. It effectively changes the resolution of the output to match that of the main screen, without changing the actual configuration of the secondary screen. This is particularly useful for making content appear the same size across screens with different resolutions.

# --output "$main_screen": This flag is used again to specify another display output that you're configuring, in this case, the main screen (e.g., DP-4).

# --mode "$main_screen_resolution": This option sets the resolution of the main screen. The resolution is given by $main_screen_resolution (e.g., 2560x1600). This ensures that the main screen operates at its specified resolution.

# --same-as "$secondary_screen": This flag configures the main screen to mirror its display to the secondary screen. It positions the output of the main screen in the same location as the secondary screen, effectively creating a mirrored display where both screens show the same content.
    xrandr --output "$secondary_screen" --scale-from "$main_screen_resolution" --output "$main_screen" --mode "$main_screen_resolution" --same-as "$secondary_screen"
    echo "Configured $secondary_screen to mirror $main_screen at resolution $main_screen_resolution."
fi

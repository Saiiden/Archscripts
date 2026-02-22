#!/bin/bash

#vmwarewm: Launch VMware safely under Wayland/Xwayland

# Disables advanced XKB options that cause VMware to crash, then restores them on exit.
set -euo pipefail

restore_xkb() {
echo "Restoring XKB options..."
if [ -n "$original_xkb_options" ]; then
setxkbmap -option "$original_xkb_options"
else
setxkbmap -option ""
fi
}

# Save current XKB options
original_xkb_options=$(setxkbmap -query | awk '/options/ {print $2}')
echo "Saved XKB options: ${original_xkb_options:-"(none)"}"

# Ensure XKB options are restored when this script exits (even on crash/signal)
trap restore_xkb EXIT

# Disable advanced XKB options to prevent VMware crash under Xwayland
echo "Clearing XKB options for VMware compatibility..."
setxkbmap -option ""

# Launch VMware (background, remove ampersand for foreground)
echo "Launching VMware..."
vmware&

#!/usr/bin/env sh

# get current powermode
mode=$(powerprofilesctl get)

# switch powermode
# -r 843920483 to replace notificaiton when changig -> random id used, may cause issues
if [ "$mode" = "performance" ]; then
  powerprofilesctl set balanced
  notify-send -r 843920483 -t 1500 -i "power-profile-balanced-symbolic" "Balanced" -e -h string:x-canonical-private-synchronous:"powermode"
elif [ "$mode" = "balanced" ]; then
  powerprofilesctl set power-saver
  notify-send -r 843920483 -t 1500 -i "power-profile-power-saver-symbolic" "Power saver" -e -h string:x-canonical-private-synchronous:"powermode"
else
  powerprofilesctl set performance
  notify-send -r 843920483 -t 1500 -i "power-profile-performance-symbolic" "Performance" -e -h string:x-canonical-private-synchronous:"powermode"
fi

#!/usr/bin/env bash

print_error() {
  local cmd
  cmd=$(basename "$0")
  cat <<EOF
    "${cmd}" <action> [step]
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]

    Example:
        "${cmd}" i 10    # Increase brightness by 10%
        "${cmd}" d       # Decrease brightness by default step (5%)
EOF
}

send_notification() {
  brightness=$(brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat)
  brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')

  icon="display-brightness-symbolic"

  notify-send -a "Brightness" -t 800 -i "${icon}" "${brightness}" "${brightinfo}" -h string:x-canonical-private-synchronous:"brightness" -h boolean:SWAYNC_BYPASS_DND:true -h int:value:"$brightness" -e
}

get_brightness() {
  brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
}

step=${BRIGHTNESS_STEPS:-5}
step="${2:-$step}"

case $1 in
i | -i) # increase the backlight
  if [[ $(get_brightness) -lt 10 ]]; then
    # increase the backlight by 1% if less than 10%
    step=1
  fi

  brightnessctl set +"${step}"%
  send_notification
  ;;
d | -d) # decrease the backlight

  if [[ $(get_brightness) -le 10 ]]; then
    # decrease the backlight by 1% if less than 10%
    step=1
  fi

  if [[ $(get_brightness) -le 1 ]]; then
    brightnessctl set "${step}"%
  else
    brightnessctl set "${step}"%-
  fi

  send_notification
  ;;
*) # print error
  print_error ;;
esac

#!/usr/bin/env sh


# Define functions

print_usage() {
    cat <<EOF
Usage: $(basename "$0") -[device] <action> [step]

Devices/Actions:
    -i    Input device
    -o    Output device
    -p    Player application
    -s    Select output device
    -t    Toggle to next output device

Actions:
    i     Increase volume
    d     Decrease volume
    m     Toggle mute

Optional:
    step  Volume change step (default: 5)

Examples:
    $(basename "$0") -o i 5     # Increase output volume by 5
    $(basename "$0") -i m       # Toggle input mute
    $(basename "$0") -p spotify d 10  # Decrease Spotify volume by 10 
    $(basename "$0") -p '' d 10  # Decrease volume by 10 for all players 

EOF
    exit 1
}

notify_vol() {

    mute=$(pamixer "${srce}" --get-mute | cat)

    if [ "${mute}" == "true" ]; then 
      percentage="muted"
    else
      if (( vol < 33 )); then
          percentage="low"
      elif (( vol < 66 )); then
          percentage="medium"
      else
          percentage="high"
      fi
    fi

    ico="audio-volume-${percentage}-symbolic"
    notify-send -a "Audio" -h string:x-canonical-private-synchronous:"volume-change" -t 800 -i "${ico}" "${vol}" "${nsink}" -e -h boolean:SWAYNC_BYPASS_DND:true -h int:value:"$vol"
}

notify_mute() {
    mute=$(pamixer "${srce}" --get-mute | cat)
    [ "${srce}" == "--default-source" ] && dvce="mic" || dvce="speaker"

    # Choose the correct icon
    dvce_part=$([ "${dvce}" == "mic" ] && echo "microphone-sensitivity" || echo "audio-volume")
    state_part=$([ "${mute}" == "true" ] && echo "muted" || echo "high")
    icon="${dvce_part}-${state_part}-symbolic"

    if [ "${mute}" == "true" ]; then
      notify-send -a "Audio" -h string:x-canonical-private-synchronous:"${dvce}-toggle-mute"  -t 800 -i "${icon}" "muted" "${nsink}" -e -h boolean:SWAYNC_BYPASS_DND:true
    else
        notify-send -a "Audio" -h string:x-canonical-private-synchronous:"${dvce}-toggle-mute" -t 800 -i "${icon}" "unmuted" "${nsink}" -e -h boolean:SWAYNC_BYPASS_DND:true
    fi
}

change_volume() {
    local action=$1
    local step=$2
    local device=$3
    local delta="-"
    local mode="--output-volume"

    [ "${action}" = "i" ] && delta="+"
    [ "${srce}" = "--default-source" ] && mode="--input-volume"
    case $device in
        "pamixer")            
            pamixer $srce -"$action" "$step"
            vol=$(pamixer $srce --get-volume)
            ;;
        "playerctl")
            playerctl --player="$srce" volume "$(awk -v step="$step" 'BEGIN {print step/100}')${delta}"
            vol=$(playerctl --player="$srce" volume | awk '{ printf "%.0f\n", $0 * 100 }')
            ;;
    esac
    
    notify_vol
}

toggle_mute() {
    local device=$1
    local mode="--output-volume"
    [ "${srce}" = "--default-source" ] && mode="--input-volume"
    case $device in
        "pamixer") 
            pamixer $srce -t
            notify_mute
            ;;
        "playerctl")
            local volume_file="/tmp/$(basename "$0")_last_volume_${srce:-all}"
            if [ "$(playerctl --player="$srce" volume | awk '{ printf "%.2f", $0 }')" != "0.00" ]; then
                playerctl --player="$srce" volume | awk '{ printf "%.2f", $0 }' > "$volume_file"
                playerctl --player="$srce" volume 0
            else
                if [ -f "$volume_file" ]; then
                    last_volume=$(cat "$volume_file")
                    playerctl --player="$srce" volume "$last_volume"
                else
                    playerctl --player="$srce" volume 0.5  # Default to 50% if no saved volume
                fi
            fi
            notify_mute
            ;;
    esac
}

select_output() {
    local selection=$1
    if [ -n "$selection" ]; then
        device=$(pactl list sinks | grep -C2 -F "Description: $selection" | grep Name | cut -d: -f2 | xargs)
        if pactl set-default-sink "$device"; then
            notify-send -t 2000 -r 2 -u low "Activated: $selection"
        else
            notify-send -t 2000 -r 2 -u critical "Error activating $selection"
        fi
    else
        pactl list sinks | grep -ie "Description:" | awk -F ': ' '{print $2}' | sort
    fi
}

toggle_output() {
    local default_sink=$(pamixer --get-default-sink | awk -F '"' 'END{print $(NF - 1)}')
    mapfile -t sink_array < <(select_output)
    local current_index=$(printf '%s\n' "${sink_array[@]}" | grep -n "$default_sink" | cut -d: -f1)
    local next_index=$(( (current_index % ${#sink_array[@]}) + 1 ))
    local next_sink="${sink_array[next_index-1]}"
    select_output "$next_sink"
}

# Main script logic

# Set default variables
step=5
# Parse options
while getopts "iop:st" opt; do
    case $opt in
        i) device="pamixer"; srce="--default-source"; nsink=$(pamixer --list-sources | awk -F '"' 'END {print $(NF - 1)}') ;;
        o) device="pamixer"; srce=""; nsink=$(pamixer --get-default-sink | awk -F '"' 'END{print $(NF - 1)}') ;;
        p) device="playerctl"; srce="${OPTARG}"; nsink=$(playerctl --list-all | grep -w "$srce") ;;
        s) select_output "$(select_output | rofi -dmenu -config "${confDir}/rofi/notification.rasi")"; exit ;;
        t) toggle_output; exit ;;
        *) print_usage ;;
    esac
done

shift $((OPTIND-1))

# Check if device is set
[ -z "$device" ] && print_usage

# Execute action
case $1 in
    i|d) change_volume "$1" "${2:-$step}" "$device" ;;
    m) toggle_mute "$device" ;;
    *) print_usage ;;
esac

import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import AstalBattery from "gi://AstalBattery?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import AstalWp from "gi://AstalWp?version=0.1"
import { Accessor, createBinding, createComputed, With } from "gnim"

function getBatteryInfo() {
  const battery = AstalBattery.get_default()
  const formatSecondsToHours = (seconds: number) => {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    return `${hours.toString().padStart(2, "0")}:${minutes.toString().padStart(2, "0")}`
  }

  const time_to_empty = createBinding(battery, "time_to_empty")
  const time_to_full = createBinding(battery, "time_to_full")

  return createComputed(() => {
    if (time_to_empty() == 0 && time_to_full() == 0) {
      return "Battery fully charged"
    }
    if (time_to_empty() != 0) {
      return `Empty in ${formatSecondsToHours(time_to_empty())} hours`
    }
    return `Full in ${formatSecondsToHours(time_to_full())} hours`
  })
}

function NetworkIcon() {
  const network = AstalNetwork.get_default()
  const wifi = createBinding(network, "wifi")
  const wired = createBinding(network, "wired")

  return (
    <box spacing={10}>
      <With value={wifi}>
        {(wifi) => {
          const ap = createBinding(wifi, "active_access_point")
          const enabled = createBinding(wifi, "enabled")

          return (
            wifi && (
              <image
                icon_name={createBinding(wifi, "icon_name")}
                tooltip_text={createComputed(() => {
                  if (ap()) return ap().ssid
                  return enabled() ? "..." : "Wifi is disabled"
                })}
              />
            )
          )
        }}
      </With>
      <With value={wired}>
        {(wired) => {
          return (
            wired &&
            wired.device.active_connection && (
              <image
                icon_name={createBinding(wired, "icon_name")}
                tooltip_text={createBinding(
                  wired.device.active_connection,
                  "id",
                )}
              />
            )
          )
        }}
      </With>
    </box>
  )
}

function BatteryIcon() {
  const battery = AstalBattery.get_default()

  return (
    <box spacing={4} tooltip_text={getBatteryInfo()}>
      <image icon_name={createBinding(battery, "icon_name")} />
      <label
        valign={Gtk.Align.BASELINE_CENTER}
        label={createBinding(battery, "percentage").as(
          (percentage) => Math.floor(percentage * 100) + "%",
        )}
      />
    </box>
  )
}

function AudioIcon() {
  const audio = AstalWp.get_default()

  return (
    <image
      icon_name={createBinding(audio.default_speaker, "volume_icon")}
      tooltip_text={createBinding(audio.default_speaker, "volume").as(
        (volume) => `Volume: ${Math.floor(volume * 100)}%`,
      )}
    >
      <Gtk.EventControllerScroll
        flags={Gtk.EventControllerScrollFlags.VERTICAL}
        onScroll={(_, __, y) => {
          const STEP = 0.01
          if (y != 0) {
            audio.default_speaker.volume = Math.min(
              1,
              audio.default_speaker.volume + STEP * Math.sign(y),
            )
          }
        }}
      />
    </image>
  )
}

export default function ControlCenterToggle() {
  return (
    <button
      class={"control-center"}
      onClicked={() => execAsync("swaync-client -t -sw")}
    >
      <box spacing={10}>
        <NetworkIcon />
        <BatteryIcon />
        <AudioIcon />
      </box>
    </button>
  )
}

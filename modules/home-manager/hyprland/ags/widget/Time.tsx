import { Gtk } from "ags/gtk4"
import GLib from "gi://GLib?version=2.0"
import { createState } from "gnim"

export default function Time() {
  const format = "%d. %b  %H:%M"

  const [time, setTime] = createState(
    GLib.DateTime.new_now_local().format(format) ?? "",
  )

  const updateTime = () => {
    setTime(GLib.DateTime.new_now_local().format(format) ?? "")
  }

  setInterval(() => {
    updateTime()
  }, 1000)

  return <label label={time} />
}

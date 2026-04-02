import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"
import Workspaces from "./Workspaces"
import Time from "./Time"
import SystemTray from "./SystemTray"
import ControlCenterToggle from "./ControlCenterToggle"

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        <Workspaces $type="start" />

        <Time $type="center" />

        <box $type="end" spacing={5}>
          <SystemTray />
          <ControlCenterToggle />
        </box>
      </centerbox>
    </window>
  )
}

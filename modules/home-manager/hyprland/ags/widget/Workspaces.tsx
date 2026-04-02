import { Gtk } from "ags/gtk4"
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import { createBinding, With } from "gnim"

interface WorkspaceButtonProps {
  readonly hypr: AstalHyprland.Hyprland
  readonly workspace: AstalHyprland.Workspace
}

function WorkspaceButton({ hypr, workspace }: WorkspaceButtonProps) {
  const focused = createBinding(hypr, "focusedWorkspace").as(
    (focusedWorkspace) => focusedWorkspace.id === workspace.id,
  )

  return (
    <button
      class={focused((focused) => `workspace ${focused ? "focused" : ""}`)}
      onClicked={() => workspace.focus()}
      vexpand={false}
    />
  )
}

export default function Workspaces() {
  const hypr = AstalHyprland.get_default()
  const workspaces = createBinding(hypr, "workspaces").as((wss) =>
    wss
      .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
      .sort((a, b) => a.id - b.id),
  )

  return (
    <box class={"workspace-container"}>
      <With value={workspaces}>
        {(workspaces) => {
          return (
            <box spacing={6} valign={Gtk.Align.CENTER}>
              {workspaces.map((workspace) => (
                <WorkspaceButton hypr={hypr} workspace={workspace} />
              ))}
            </box>
          )
        }}
      </With>
    </box>
  )
}

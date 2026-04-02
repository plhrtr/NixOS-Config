import { Gtk } from "ags/gtk4"
import AstalTray from "gi://AstalTray?version=0.1"
import { createBinding, createState, With } from "gnim"

function SystemTrayItem({ item }: { readonly item: AstalTray.TrayItem }) {
  const popover = Gtk.PopoverMenu.new_from_model(item.menuModel)
  popover.has_arrow = false

  return (
    <menubutton
      $={(self) => {
        self.insert_action_group("dbusmenu", item.actionGroup)
      }}
      tooltipText={createBinding(item, "tooltipMarkup")}
      class={"system-tray-item"}
      direction={Gtk.ArrowType.UP}
    >
      <image gicon={createBinding(item, "gicon")} />
      {popover}
    </menubutton>
  )
}

export default function SystemTray() {
  const tray = AstalTray.get_default()
  const trayItems = createBinding(tray, "items")

  const [icon, setIcon] = createState("go-up-symbolic")

  return (
    <menubutton class={"system-tray"} tooltip_text={"Open the system tray"}>
      <image icon_name={icon} />
      <popover
        has_arrow={false}
        $={(self) =>
          self.connect("notify::visible", () =>
            setIcon(self.visible ? "go-down-symbolic" : "go-up-symbolic"),
          )
        }
      >
        <With value={trayItems}>
          {(items) => {
            return (
              <Gtk.FlowBox
                max_children_per_line={5}
                can_focus={false}
                selection_mode={Gtk.SelectionMode.NONE}
              >
                {items.map((item) => (
                  <SystemTrayItem item={item} />
                ))}
              </Gtk.FlowBox>
            )
          }}
        </With>
      </popover>
    </menubutton>
  )
}

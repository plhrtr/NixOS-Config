{ ... }:
{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_FEATURES = "UseOzonePlatform";
    ELECTRON_OZONE_PLATFORM = "wayland";
  };

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
}

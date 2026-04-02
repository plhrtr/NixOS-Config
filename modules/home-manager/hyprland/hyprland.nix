{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.file.".config/hypr".source = ./hypr;
  home.file.".config/swaync".source = ./swaync;
  home.file.".config/matugen".source = ./matugen;
  home.file.".config/gtk-3.0/gtk.css".source = ./gtk-3.0/gtk.css;
  home.file.".config/gtk-4.0/gtk.css".source = ./gtk-4.0/gtk.css;
  home.file.".config/gtk-4.0/gtk-dark.css".source = ./gtk-4.0/gtk-dark.css;

  home.file.".config/scripts/" = {
    source = ./scripts;
    executable = true;
  };

  home.packages = with pkgs; [
    hyprland
    hyprpaper
    hyprsunset
    hyprlock
    hypridle
    hyprshot
    hyprpicker
    vicinae
    swaynotificationcenter
    matugen
    networkmanagerapplet
    adw-gtk3
    pamixer
    playerctl
    brightnessctl
    power-profiles-daemon
    libnotify
  ];

  home.activation.generateTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.matugen}/bin/matugen image ${toString ./default-wallpaper.jpg}
  '';

}

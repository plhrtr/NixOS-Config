{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

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

  programs.ags = {
    enable = true;

    configDir = ./ags;

    # additional packages and executables to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.system}.tray
      inputs.astal.packages.${pkgs.system}.hyprland
      inputs.astal.packages.${pkgs.system}.network
      inputs.astal.packages.${pkgs.system}.bluetooth
      inputs.astal.packages.${pkgs.system}.battery
      inputs.astal.packages.${pkgs.system}.wireplumber
      fzf
    ];
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
    pamixer
    playerctl
    brightnessctl
    power-profiles-daemon
    libnotify
    caffeine-ng
    pasystray
  ];

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };

  home.activation.generateTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.matugen}/bin/matugen image ${toString ./default-wallpaper.jpg}
  '';

}

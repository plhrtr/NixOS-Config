{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
  };

  home = {
    file = {
      ".config/hypr" = {
        source = ./hypr;
        recursive = true;
        force = true;
      };
      ".config/swaync" = {
        source = ./swaync;
        recursive = true;
        force = true;
      };
      ".config/matugen" = {
        source = ./matugen;
        recursive = true;
        force = true;
      };
      ".config/qt5ct" = {
        source = ./qt5ct;
        recursive = true;
        force = true;
      };
      ".config/qt6ct" = {
        source = ./qt6ct;
        recursive = true;
        force = true;
      };
      ".config/gtk-3.0" = {
        source = ./gtk-3.0;
        recursive = true;
        force = true;
      };
      ".config/gtk-4.0" = {
        source = ./gtk-4.0;
        recursive = true;
        force = true;
      };
      ".config/scripts/" = {
        source = ./scripts;
        executable = true;
        recursive = true;
        force = true;
      };
    };

    packages = with pkgs; [
      hyprpaper
      hyprsunset
      hyprlock
      hypridle
      hyprshot
      hyprpicker
      swaynotificationcenter
      matugen
      pamixer
      playerctl
      brightnessctl
      power-profiles-daemon
      libnotify
      pywalfox-native
      pywal
      caffeine-ng
      networkmanagerapplet
    ];
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

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  services = {
    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.nautilus}/bin/nautilus";
        };
      };
    };
    batsignal = {
      enable = true;
      extraArgs = [
        "-I"
        "battery-caution-symbolic"
        "-e"
      ];
    };
    blueman-applet.enable = true;
    pasystray = {
      extraOptions = [
        "--notify=none"
      ];
      enable = true;
    };
    caffeine.enable = true;
    network-manager-applet.enable = true;
  };

  dconf.settings = {
    "org/gnome/nm-applet" = {
      disable-connected-notifications = false;
      disable-disconnected-notifications = false;
    };
  };

  xdg.configFile."uwsm/env".text = ''
    QT_QPA_PLATFORM="wayland;xcb"
    QT_QPA_PLATFORMTHEME="qt6ct"
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    QT_AUTO_SCREEN_SCALE_FACTOR=1
    MOZ_ENABLE_WAYLAND=1
    GDK_SCALE=1
  '';

  home.activation.generateTheme = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${pkgs.matugen}/bin/matugen image ${toString ./default-wallpaper.jpg} --source-color-index 0
  '';
}

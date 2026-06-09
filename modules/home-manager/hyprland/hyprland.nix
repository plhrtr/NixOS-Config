{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home = {
    file = {
      ".config/hypr" = {
        source = ./hypr;
        recursive = true;
      };
      ".config/swaync" = {
        source = ./swaync;
        recursive = true;
      };
      ".config/matugen" = {
        source = ./matugen;
        recursive = true;
      };
      ".config/qt5ct" = {
        source = ./qt5ct;
        recursive = true;
      };
      ".config/qt6ct" = {
        source = ./qt6ct;
        recursive = true;
      };
      ".config/gtk-3.0" = {
        source = ./gtk-3.0;
        recursive = true;
      };
      ".config/gtk-4.0" = {
        source = ./gtk-4.0;
        recursive = true;
      };
      ".config/scripts/" = {
        source = ./scripts;
        executable = true;
        recursive = true;
      };
    };

    packages = with pkgs; [
      hyprland
      hyprpaper
      hyprsunset
      hyprlock
      hypridle
      hyprshot
      hyprpicker
      swaynotificationcenter
      matugen
      networkmanagerapplet
      pamixer
      playerctl
      brightnessctl
      power-profiles-daemon
      libnotify
      caffeine-ng
      pywalfox-native
      pywal
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
    network-manager-applet.enable = true;
    caffeine.enable = true;
    pasystray.enable = true;
  };

  dconf.settings = {
    "org/gnome/nm-applet" = {
      disable-connected-notifications = false;
      disable-disconnected-notifications = false;
    };
  };

  services.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
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

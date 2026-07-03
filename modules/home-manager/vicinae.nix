{ pkgs, inputs, ... }: {
  services.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    settings = {
      pop_to_root_on_close = true;
      search_files_in_root = true;
      favicon_service = "twenty";
      launcher_window = {
        opacity = 0.9;
      };
      theme = {
        light = {
          name = "material";
          icon_theme = "Adwaita";
        };
        dark = {
          name = "material";
          icon_theme = "Adwaita";
        };
      };
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        pulseaudio
        hyprland-monitors
        nix
        wifi-commander
        bluetooth
      ];

      providers = {
        "@marcjulian/store.raycast.obsidian" = {
          preferences = {
            configFileName = ".obsidian";
            vaultPath = "/home/paul/Documents/Notizen\n";
          };
        };
        "clipboard" = {
          preferences = {
            encryption = true;
            eraseOnStartup = true;
            ignorePasswords = true;
            monitoring = true;
          };
        };
      };
    };
  };

}

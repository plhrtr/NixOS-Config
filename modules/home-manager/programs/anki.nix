{ pkgs, ... }:
{
  programs.anki = {
    enable = true;
    addons = with pkgs.ankiAddons; [
      (anki-connect.withConfig {
        config = {
          "apiKey" = null;
          "apiLogPath" = null;
          "webBindAddress" = "127.0.0.1";
          "webBindPort" = 8765;
          "webCorsOrigin" = "http://localhost";
          "webCorsOriginList" = [
            "http://localhost"
            "app://obsidian.md"
          ];
        };
      })
    ];
  };
}

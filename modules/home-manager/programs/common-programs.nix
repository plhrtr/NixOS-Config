{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Gnome suite
    gnome-clocks
    nautilus
    papers
    loupe
    gnome-music
    showtime

    inkscape
    gimp
    obsidian
    nextcloud-client
    chromium
    spotify
    thunderbird
    discord

    nodejs_20
  ];
}

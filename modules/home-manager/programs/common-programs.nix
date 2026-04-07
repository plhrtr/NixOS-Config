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
    sushi

    # Misc
    satty # screenshot annotator

    # Apps
    inkscape
    gimp
    obsidian
    nextcloud-client
    chromium
    spotify
    thunderbird
    discord
  ];
}

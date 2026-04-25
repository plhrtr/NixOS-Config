{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Gnome suite
    gnome-clocks
    nautilus
    loupe
    gnome-music
    showtime
    sushi

    # Misc
    satty # screenshot annotator

    # Apps
    zathura
    inkscape
    gimp
    obsidian
    nextcloud-client
    chromium
    thunderbird
    discord
    valent
  ];
}

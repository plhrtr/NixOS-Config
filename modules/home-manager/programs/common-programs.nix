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
    steam-run # Run apps in the steam FHS environment

    # Apps
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

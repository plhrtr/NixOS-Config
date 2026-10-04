{ pkgs, ... }:
{

  home.packages = with pkgs; [
    # Gnome suite
    gnome-clocks
    nautilus
    loupe
    papers
    gnome-music
    showtime
    sushi
    file-roller
    warp

    # Misc
    satty # screenshot annotator
    steam-run # Run apps in the steam FHS environment
    nextcloud-client

    # Apps
    inkscape
    gimp
    darktable
    obsidian
    chromium
    thunderbird
    discord
    valent
  ];
}

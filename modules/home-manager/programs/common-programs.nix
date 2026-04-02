{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Gnome suite
    gnome-clocks
    nautilus
    papers

    inkscape
    gimp
    obsidian
  ];
}

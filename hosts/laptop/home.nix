{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/home-manager/shell/default.nix
    ../../modules/home-manager/programs/common-programs.nix
    ../../modules/home-manager/programs/browser.nix
    ../../modules/home-manager/programs/terminal.nix
    ../../modules/home-manager/hyprland/hyprland.nix
    ../../modules/home-manager/gtk.nix
  ];

  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}

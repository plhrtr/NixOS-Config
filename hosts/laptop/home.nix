{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/home-manager/shell/default.nix
    ../../modules/home-manager/programs/common-programs.nix
    ../../modules/home-manager/programs/browser.nix
    ../../modules/home-manager/programs/terminal.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/tmux.nix
    ../../modules/home-manager/programs/spotify.nix
    ../../modules/home-manager/programs/anki.nix
    ../../modules/home-manager/hyprland/hyprland.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/electron-wayland.nix
    ../../modules/home-manager/lazyvim/lazyvim.nix
  ];

  home = {
    username = "paul";
    homeDirectory = "/home/paul";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}

{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/home-manager/shell/default.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/tmux.nix
    ../../modules/home-manager/lazyvim/lazyvim.nix
  ];

  home = {
    username = "paul";
    homeDirectory = "/home/paul";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}

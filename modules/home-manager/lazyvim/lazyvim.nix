{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Linter and formatter
      statix

      # LSPs
      lua-language-server
      nil
    ];   
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = ./nvim;
}

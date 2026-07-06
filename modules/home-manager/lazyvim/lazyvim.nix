{ pkgs, ... }:
{
  programs.neovim = {
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    # Linter and formatter
    statix

    # LSPs
    lua-language-server
    nil
  ];
}

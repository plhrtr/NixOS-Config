{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Lazy Vim
      ripgrep
      fd
      gcc
      vimPlugins.nvim-treesitter.withAllGrammars
      tree-sitter

      # Linter and formatter
      ruff
      statix

      # LSPs
      lua-language-server
      nil

    ];
  };

  # xdg.configFile."nvim" = {
  #   source = ./nvim;
  #   recursive = true;
  # };
}

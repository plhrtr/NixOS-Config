{
  pkgs,
  config,
  ...
}:
{
  programs.neovim = {
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    # Linter and formatter
    statix
    tree-sitter

    # LSPs
    lua-language-server
    nil
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
}

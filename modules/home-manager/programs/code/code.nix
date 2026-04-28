{ pkgs, ... }:
{
  home.file.".vscode/extensions/material-3" = {
    source = ./material-3;
    recursive = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
      userSettings = {
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        "workbench.colorTheme" = "Material 3";

        # Vim
        "vim.useSystemClipboard" = true;
        "vim.hlsearch" = true;
        "vim.incsearch" = true;
        "vim.handleKeys" = {
          "<C-p>" = false;
          "<C-f>" = false;
          "<C-k>" = false;
        };
        "vim.insertModeKeyBindings" = [
          {
            "before" = [
              "j"
              "k"
            ];
            "after" = [ "<Esc>" ];
          }
        ];
      };
    };
  };
}

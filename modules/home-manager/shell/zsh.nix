{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
    };

    shellAliases = {
      c = "clear"; # clear terminal
      l = "eza -lh  --icons=auto"; # long list
      ls = "eza -1   --icons=auto"; # short list
      ll = "eza -lha --icons=auto --sort=name --group-directories-first"; # long list all
      ld = "eza -lhD --icons=auto"; # long list dirs
      lt = "eza --icons=auto --tree"; # list folder as tree
      cd = "z"; # use zoxide instead of cd
      cat = "bat"; # formatted cat
      ".." = "cd ..";
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
    };

    history.size = 10000;

  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];
}

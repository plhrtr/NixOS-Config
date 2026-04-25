{ ... }:
{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Paul Harter";
      email = "pl.hrtr@gmail.com";
    };
    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}

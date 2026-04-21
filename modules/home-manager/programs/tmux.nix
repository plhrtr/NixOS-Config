{ ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Switch panes using vim-directions
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D
    '';
  };
}

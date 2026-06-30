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

      # Default colors 
      set -g status-bg                          "#130d07"
      set -gq @thm_bar_bg                       "#130d07"

      set -gq @thm_bg                           "#19120c"
      set -gq @thm_fg                           "#eee0d5"
      set -gq @thm_primary                      "#fcb974"
      set -gq @thm_inverse_primary              "#855318"
      set -gq @thm_surface_low                  "#211a14"
      set -gq @thm_surface                      "#261e18"
      set -gq @thm_surface_variant              "#302921"
      set -gq @thm_outline                      "#50453a"
      set -gq @thm_text_variant                 "#d5c3b5"

      set -g status-style                       "bg=#{@thm_bg},fg=#{@thm_fg}"
      set -g window-active-style                "bg=#{@thm_bg},fg=#{@thm_fg}"

      # Source the generated theme file
      source-file ~/.config/tmux/theme.conf

      # Theme settings 
      set -g status "on"
      set -g status-justify "left"
      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g pane-border-style "fg=#{@thm_surface_variant}"
      set -g pane-active-border-style "fg=#{@thm_primary}"

      set -g message-style "bg=#{@thm_surface},fg=#{@thm_primary}"
      set -g message-command-style "bg=#{@thm_surface},fg=#{@thm_primary}"

      set -g mode-style "bg=#{@thm_inverse_primary},fg=#{@thm_fg}"

      set -g status-left "#[bg=#{@thm_primary},fg=#{@thm_bg},bold] #S #[bg=#{@thm_bg},fg=#{@thm_primary}] "

      set -g status-right "#[fg=#{@thm_text_variant},bg=#{@thm_surface_low}] %Y-%m-%d │ %H:%M #[fg=#{@thm_bg},bg=#{@thm_primary},bold] #h "

      set -g window-status-format "#[fg=#{@thm_text_variant},bg=#{@thm_surface}] #I:#W "
      set -g window-status-separator " "

      set -g window-status-current-format "#[fg=#{@thm_bg},bg=#{@thm_primary},bold] #I:#W "
    '';
  };
}

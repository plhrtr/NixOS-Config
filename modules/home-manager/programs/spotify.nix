{ ... }:
{
  programs.spotify-player = {
    enable = true;
    settings = {
      theme = "Tokyo Night";
      playback_window_position = "Top";
      copy_command = {
        command = "wl-copy";
        args = [ ];
      };
      enable_notify = false;
    };
    themes = [
      {
        name = "Tokyo Night";
        palette = {
          foreground = "#c0caf5";
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
          bright_black = "#414868";
          bright_red = "#f7768e";
          bright_green = "#9ece6a";
          bright_yellow = "#e0af68";
          bright_blue = "#7aa2f7";
          bright_magenta = "#bb9af7";
          bright_cyan = "#7dcfff";
          bright_white = "#c0caf5";
        };
        component_style = {
          selection = {
            bg = "#414868";
            modifiers = [ "Bold" ];
          };
          block_title = {
            fg = "#bb9af7";
            modifiers = [ "Bold" ];
          };
          playback_track = {
            fg = "#c0caf5";
            modifiers = [ "Bold" ];
          };
          playback_album = {
            fg = "#e0af68";
          };
          playback_metadata = {
            fg = "#565f89";
          };
          playback_progress_bar = {
            bg = "#414868";
            fg = "#7aa2f7";
          };
          current_playing = {
            fg = "#9ece6a";
            modifiers = [ "Bold" ];
          };
          page_desc = {
            fg = "#7dcfff";
            modifiers = [ "Bold" ];
          };
          table_header = {
            fg = "#f7768e";
            modifiers = [ "Bold" ];
          };
          border = {
            fg = "#414868";
          };
          playback_status = {
            fg = "#9ece6a";
            modifiers = [ "Bold" ];
          };
          playback_artists = {
            fg = "#bb9af7";
            modifiers = [ "Bold" ];
          };
          playlist_desc = {
            fg = "#565f89";
          };
        };
      }
    ];
  };
}

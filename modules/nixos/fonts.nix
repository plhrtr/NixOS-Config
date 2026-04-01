{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # Core UI fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Nerd fonts (for Neovim/icons)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code

    # Good programming fonts
    jetbrains-mono
    fira-code

    # Fallbacks / web compatibility
    liberation_ttf
    dejavu_fonts
  ];
}

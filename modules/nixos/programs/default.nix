{ pkgs, ... }:
{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Core CLI tools
    git
    curl
    wget
    vim
    neovim
    htop
    btop
    tree
    unzip
    zip
    gnupg
    ripgrep
    fd
    fzf
    wl-clipboard

    # Shell & utils
    zsh

    # Dev tools
    gcc
    gnumake
    pkg-config
    cmake
    man-db
    man-pages

    # Debugging / system
    strace
    ltrace
    lsof
    file
    which

    # Networking
    dig # dnsutils
    nmap
    tcpdump

    # Misc useful
    killall
    pciutils
    usbutils
    adw-gtk3
    bibata-cursors
  ];

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}

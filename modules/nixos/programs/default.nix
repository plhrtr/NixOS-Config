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
    eza
    bat
    ripgrep
    fd
    fzf
    zoxide

    # Shell & utils
    zsh
    tmux

    # Dev tools
    gcc
    gnumake
    pkg-config
    cmake

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
  ];

  # Editor
  programs.neovim.defaultEditor = true;

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}

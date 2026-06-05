{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/programs/default.nix
    ../../modules/nixos/services/default.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/internationalization.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "paul";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # For KDEConnect
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };

  services.gnome.gnome-keyring.enable = true;

  # Display Manager
  services.displayManager.gdm.enable = true;

  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/login-screen" = {
          logo = "";
        };
        "org/gnome/desktop/interface" = {
          cursor-theme = "Bibata-Modern-Ice";
          cursor-size = lib.gvariant.mkInt32 20;
        };
      };
    }
  ];

  #Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  # Home manager config
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "paul" = import ./home.nix;
    };
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.paul = {
    isNormalUser = true;
    description = "Paul";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
    ];
  };

  services.udev.extraRules = ''
    # STMicroelectronics STM32 Device in DFU Mode | For Betaflight
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"
  '';

  # Enables udev rules for stm32 development via st-link
  services.udev.packages = [ pkgs.stlink ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.gvfs.enable = true;

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };

  system.stateVersion = "25.11";
}

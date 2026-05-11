{
  inputs,
  lib,
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
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
    # SEGGER J-Link
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="0666", GROUP="plugdev"

    # ST-Link (for good measure)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="0666", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="0666", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="0666", GROUP="plugdev"
  '';

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

  system.stateVersion = "25.11";
}

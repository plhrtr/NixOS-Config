{ ... }:
{
  imports = [
    ./cups.nix
    ./pipewire.nix
    ./blueman.nix
    ./upower.nix
    ./tlp.nix
  ];

  # USB decives
  services.udisks2.enable = true;

}

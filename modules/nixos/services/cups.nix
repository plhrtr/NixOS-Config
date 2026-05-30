{ ... }:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
  };

  # Wifi Printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}

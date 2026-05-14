{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix
    # Shared configuration
    ../configuration.nix
  ];

  # Machine-specific settings
  networking.hostName = "simbook";

  # Laptop power management (AMD)
  services.tlp.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  # Touchpad
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };

  # Brightness control
  # programs.light.enable = true;
}

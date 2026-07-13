{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix
    # Shared configuration
    ../configuration.nix
  ];

  # Machine-specific settings
  networking.hostName = "simpc";
}

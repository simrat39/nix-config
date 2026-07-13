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

  # Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}

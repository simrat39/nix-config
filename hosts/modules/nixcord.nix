{ config, pkgs, ... }:
{
  programs.nixcord = {
    enable = true;          # Enable Nixcord (It also installs Discord)
    vesktop.enable = true;  # Vesktop
  };
}

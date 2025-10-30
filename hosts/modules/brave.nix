{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder"
      "--ozone-platform=wayland"
      "--enable-wayland-ime" 
    ];
  };
}

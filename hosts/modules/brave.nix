{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime" 
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiIgnoreDriverChecks"
      "--enable-accelerated-video-decode"
      "--enable-zero-copy"
      "--use-gl=egl"
    ];
  };
}

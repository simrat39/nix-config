{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiIgnoreDriverChecks,Vulkan"
      "--enable-accelerated-video-decode"
      "--enable-zero-copy"
      "--use-gl=egl"
      "--enable-gpu-rasterization"
      "--enable-oop-rasterization"
      "--ignore-gpu-blocklist"
    ];
  };
}

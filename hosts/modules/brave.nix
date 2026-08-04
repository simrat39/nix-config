{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    # ponytail: no commandLineArgs — NIXOS_OZONE_WL=1 (home.nix) makes the
    # brave wrapper add wayland + wayland-ime flags itself
    package = pkgs.brave;
  };
}

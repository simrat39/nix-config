{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };

  # ponytail: brave reads brave-flags.conf natively; avoids hm's
  # cfg.package.override, which pkgs.brave no longer supports.
  # NIXOS_OZONE_WL=1 (home.nix) still adds the wayland flags;
  # this only turns on VA-API decode (off by default on linux chromium).
  # Old flag name kept for older brave versions, unknown features are ignored.
  xdg.configFile."brave-flags.conf".text = ''
    --enable-features=AcceleratedVideoDecodeLinuxGL,VaapiVideoDecodeLinuxGL
  '';

  # ponytail: google-chrome's nixpkgs wrapper reads chrome-flags.conf the same way
  xdg.configFile."chrome-flags.conf".text =
    config.xdg.configFile."brave-flags.conf".text;
}

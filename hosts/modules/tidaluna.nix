{ config, pkgs, inputs, ... }:

{
  # Install TidaLuna (TIDAL with Luna injection)
  environment.systemPackages = [
    inputs.tidaluna.packages.${pkgs.system}.default
  ];
}

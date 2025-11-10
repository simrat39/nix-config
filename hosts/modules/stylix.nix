{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    image = ../../assets/wallpapers/car.png;
    polarity = "dark";
  };
}

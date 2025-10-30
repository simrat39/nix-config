{ config, pkgs, ... }:
{
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      font = "monospace";
      background-color = "#000A";
    };
  };

  # Clear tofi cache on every rebuild
  home.activation.clearTofiCache = {
    after = [ "writeBoundary" ];
    before = [ ];
    data = ''
      rm -rf $HOME/.cache/tofi*
    '';
  };
}

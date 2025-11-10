{ config, pkgs, ... }:
{
  # Disable stylix automatic theming for tofi
  stylix.targets.tofi.enable = false;

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

      # Use stylix colors
      font = config.stylix.fonts.monospace.name;
      background-color = "#00000080";
      text-color = config.lib.stylix.colors.withHashtag.base05;
      selection-color = config.lib.stylix.colors.withHashtag.base0D;
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

{ config, lib, pkgs, ... }:
let
  settings = builtins.fromJSON(builtins.readFile ./settings.json);
  session = builtins.fromJSON(builtins.readFile ./session.json);
in
{
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    niri = {
      enableSpawn = true;
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
        filesToInclude = [
          "alttab"
          "outputs"
          "binds"
          "colors"
          "layout"
          "wpblur"
        ];
      };
    };
    settings = lib.mkForce settings;
    session = lib.mkForce session;
  };
}

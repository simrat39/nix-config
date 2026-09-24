{ config, lib, pkgs, inputs, ... }:
let
  settings = builtins.fromJSON(builtins.readFile ./settings.json);
  session = builtins.fromJSON(builtins.readFile ./session.json);
in
{
  programs.dank-material-shell = {
    enable = true;
    # ponytail: upstream stable ships a stale vendorHash; drop this once upstream fixes it
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: {
      vendorHash = "sha256-Ls6Dquwt0fzDCEjZ6FfTsZTXDI8408mFdByv/OWHVgI=";
    });
    systemd.enable = true;
    niri = {
      enableSpawn = false;
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

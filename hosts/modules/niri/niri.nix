{ config, pkgs, hostName, ... }:
let
  hostSnippet = ../.. + "/${hostName}/niri.kdl";
in
{
  programs.niri = {
    config = builtins.readFile ./config.kdl
      + (if builtins.pathExists hostSnippet then builtins.readFile hostSnippet else "");
  };
}

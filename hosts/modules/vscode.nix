{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        anthropic.claude-code
        vscodevim.vim
        bradlc.vscode-tailwindcss
      ];
    };
  };
}

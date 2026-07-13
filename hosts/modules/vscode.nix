{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      userSettings = {
        "diffEditor.renderSideBySide" = false;
      };
      extensions = with pkgs.vscode-extensions; [
        # anthropic.claude-code  # temporarily disabled: nix-vscode-extensions hash mismatch for v2.1.92 (upstream silent republish)
        vscodevim.vim
        bradlc.vscode-tailwindcss
      ];
    };
  };
}

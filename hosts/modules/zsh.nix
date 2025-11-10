{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      cd = "z";
    };
  };

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			add_newline = false;
			line_break.disabled = true;
		};
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
}

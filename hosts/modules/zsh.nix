{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      cd = "z";
    };

    # ponytail: single dir-local alias hardcoded; generalize to a .zsh-aliases loader if more dirs need this
    initContent = ''
      autoload -U add-zsh-hook
      _eagle_aliases() {
        if [[ $PWD == /home/simrat39/work/eagle-hq(|/*) ]]; then
          alias devsync='gcloud run jobs execute eagle-hq-sync --project eagle-dev-71140 --region us-central1 --args="sync_main.py,--full" --wait'
        else
          unalias devsync 2>/dev/null
        fi
      }
      add-zsh-hook chpwd _eagle_aliases
      _eagle_aliases
    '';
  };

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
    settings = pkgs.lib.importTOML "${pkgs.starship}/share/starship/presets/nerd-font-symbols.toml" // {
			add_newline = false;
			line_break.disabled = true;
    };
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
}

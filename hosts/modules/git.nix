{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings.user = { 
      name = "Simrat Grewal";
      email = "simrats169169@gmail.com";
    };
    extraConfig = {
      credentials.helper = "!gh auth git-credential";
    };
    aliases = {
      # Add and commit with current NixOS generation
      acg = "!f() { \
        generation=$(nixos-rebuild list-generations | head -2 | tail -1 | sed 's/\\s.*//'); \
        git add -A && git commit -m \"NixOS Generation $generation\"; \
      }; f";
    };
		delta = {
    	enable = true;
    	options = {
      	navigate = true;
      	line-numbers = true;
      	syntax-theme = "Dracula";
    	};
  	};
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}

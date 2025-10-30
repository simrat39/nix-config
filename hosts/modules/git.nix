{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings.user = { 
      name = "Simrat Grewal";
      email = "simrats169169@gmail.com";
    };
    extraConfig = {
      credentials.helper = "!gh auth git-credential";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}

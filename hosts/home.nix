{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.nixcord.homeModules.nixcord



    ./modules/git.nix
    ./modules/brave.nix
    ./modules/tofi.nix
    ./modules/niri/niri.nix
    ./modules/xdg_portal.nix
    ./modules/gtk.nix
    ./modules/nixcord.nix
  ];

  nixpkgs.overlays = [ inputs.claude-code.overlays.default ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "simrat39";
  home.homeDirectory = "/home/simrat39";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    wl-clipboard
    eza
    bat
    ripgrep
    claude-code
    dconf

    android-tools
    android-studio
    scrcpy 
    spotify
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font Mono"];
    };
  }; 

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/simrat39/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/Android/Sdk/platform-tools"
    "${config.home.homeDirectory}/Android/Sdk/tools"
    "${config.home.homeDirectory}/Android/Sdk/tools/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "Nightfox";
    font = {
      name = "JetBrainsMonoNL Nerd Font Mono";
      size = 12;
    };
    settings = {
      adjust_line_height = "140%";
      enable_audio_bell = "no";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      adjust_column_width = 0;
      linux_display_server = "wayland";
    };
  };

  programs.dankMaterialShell.enable = true;
  programs.dankMaterialShell.enableSystemd = true;

  programs.neovim.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
    };
  };
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.nixcord.homeModules.nixcord

    ./modules/git.nix
    ./modules/brave.nix
    ./modules/tofi.nix
    ./modules/niri/niri.nix
    ./modules/nixcord.nix
    ./modules/zoxide.nix
    ./modules/xdg.nix
    ./modules/zsh.nix
    ./modules/nvim/nvim.nix
    ./modules/vscode.nix
  ];

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
    wl-clipboard
    dconf

    eza
    bat
    ripgrep
    claude-code
    android-tools
    python3
    microfetch
    zip
    unzip
    ktlint
    nodejs

    scrcpy 
    mpv
    android-studio
    spotify
    firefox
    nautilus
    eog
  ];

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

    ".ideavimrc".text = ''
      " Tab navigation keymaps
      nnoremap <Tab> :action NextTab<CR>
      nnoremap <S-Tab> :action PreviousTab<CR>
      nnoremap <Space>x :action CloseContent<CR>
      nmap ge :action GotoNextError<CR>
      nmap gE :action GotoPreviousError<CR>
    '';
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
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  home.sessionPath = [];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
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

  stylix.iconTheme = {
    enable = true;
    package = pkgs.gruvbox-plus-icons;
    dark = "Gruvbox-Plus-Dark";
    light = "Gruvbox-Plus-Light";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
}

# Shared configuration across all machines
{ config, pkgs, ... }:

{
  imports = [
    ./modules/stylix.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # AMD GPU drivers (RADV is enabled by default)
      rocmPackages.clr.icd

      # Video acceleration
      libva
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };

  hardware.opengl.enable = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems = [ "ntfs" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.firewall.allowedUDPPorts = [ 7742 8889 8892 7777 ];
  networking.firewall.allowedTCPPorts = [ 3000 7777 ];

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simrat39 = {
    isNormalUser = true;
    description = "Simrat Grewal";
    extraGroups = [ "networkmanager" "wheel" "kvm" "video" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sbctl
    efibootmgr
    gruvbox-plus-icons
    claude-desktop

    # X11 apps (Steam etc.) under niri
    xwayland-satellite-unstable

    # GPU/Graphics utilities
    mesa
    vulkan-tools
    mesa-demos

    # Gaming
    mangohud
    protonup-qt
  ];

  programs.zsh.enable = true;

  # Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.gnome.gnome-keyring.enable = true;

  services.gvfs.enable = true;

  # Let wheel users mount internal drives from Nautilus without a password
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Hide the internal Windows (NTFS) partitions from Nautilus.
  # ponytail: matches any non-USB NTFS volume; switch to ENV{ID_FS_UUID}=="..." if you
  # ever want one of them back.
  services.udev.extraRules = ''
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_BUS}!="usb", ENV{UDISKS_IGNORE}="1"
  '';

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  systemd.settings.Manager.DefaultLimitNOFILE = "65536:524288";
  systemd.user.settings.Manager.DefaultLimitNOFILE = "65536:524288";

  security.pam.loginLimits = [
    { domain = "*"; type = "soft"; item = "nofile"; value = "65536"; }
    { domain = "*"; type = "hard"; item = "nofile"; value = "524288"; }
  ];
}

# Shared configuration across all machines
{ config, pkgs, ... }:

{
  imports = [
    ./modules/stylix.nix
    ./modules/tidaluna.nix
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

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

    # GPU/Graphics utilities
    mesa
    vulkan-tools
    mesa-demos
  ];

  programs.zsh.enable = true;

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.gnome.gnome-keyring.enable = true;

  services.gvfs.enable = true;

  # DJI RC Pro MTP support
  services.udev.extraRules = ''
    ATTR{idVendor}=="2ca3", ATTR{idProduct}=="1021", ENV{ID_MTP_DEVICE}="1", ENV{ID_MEDIA_PLAYER}="1"
  '';

  # Eagle Eyes telemetry UDP broadcast
  networking.firewall.allowedUDPPorts = [ 7742 ];

  programs.nix-ld.enable = true;
}

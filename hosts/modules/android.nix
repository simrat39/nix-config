{ config, pkgs, ... }:
{
  programs.adb = {
    enable = true;
  };

  android-sdk.enable = true;
  android-sdk.packages = sdk: with sdk; [
    build-tools-34-0-0
    cmdline-tools-latest
    emulator
    platforms-android-34
    sources-android-34
  ];
}

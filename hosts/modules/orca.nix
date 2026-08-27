{ pkgs, ... }:

let
  # ponytail: upstream has no flake; wrap the release AppImage. Bump version+hash to update.
  version = "1.4.184";
  orca = pkgs.appimageTools.wrapType2 rec {
    pname = "orca";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/stablyai/orca/releases/download/v${version}/orca-linux.AppImage";
      hash = "sha256-we74NUJ9DVCsGCQmsSiwIRfMQEOmO/A+g+5VeJQ/T6g=";
    };

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        install -Dm444 ${contents}/orca-ide.desktop $out/share/applications/orca-ide.desktop
        substituteInPlace $out/share/applications/orca-ide.desktop \
          --replace-quiet 'Exec=AppRun' 'Exec=orca'
        cp -r ${contents}/usr/share/icons $out/share/ || true
      '';
  };
in
{
  home.packages = [ orca ];
}

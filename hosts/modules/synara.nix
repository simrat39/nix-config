{ pkgs, ... }:

let
  # ponytail: upstream has no flake; wrap the release AppImage. Bump pname/version+hash to update.
  version = "0.6.6";
  synara = pkgs.appimageTools.wrapType2 rec {
    pname = "synara";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/Emanuele-web04/synara/releases/download/v${version}/Synara-${version}-x86_64.AppImage";
      hash = "sha256-kQ5oRG7ab1py7PFFbtvCryU2IjlbY9yVGBScQI65uKk=";
    };

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        install -Dm444 ${contents}/synara.desktop $out/share/applications/synara.desktop
        substituteInPlace $out/share/applications/synara.desktop \
          --replace-quiet 'Exec=AppRun' 'Exec=synara'
        cp -r ${contents}/usr/share/icons $out/share/ || true
      '';
  };
in
{
  home.packages = [ synara ];
}

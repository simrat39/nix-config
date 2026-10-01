{ pkgs, ... }:

let
  # ponytail: upstream has no flake; wrap the release tarball. Bump version+hash to update.
  version = "0.2.101";
  zeron = pkgs.stdenv.mkDerivation {
    pname = "zeron";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/zeronsh/zeron/releases/download/v${version}/zeron-${version}-linux-x86_64.tar.gz";
      hash = "sha256-JVpz3TPE8uQwai2P+4QlblnOAtb5vGjO8QxxiKvLifg=";
    };

    nativeBuildInputs = with pkgs; [ autoPatchelfHook wrapGAppsHook3 ];
    buildInputs = with pkgs; [ stdenv.cc.cc.lib libxkbcommon xorg.libxcb ];
    # dlopen'd at runtime (Tauri/webkit), not in DT_NEEDED
    runtimeDependencies = with pkgs; [ webkitgtk_4_1 gtk3 glib gdk-pixbuf libsoup_3 wayland libGL ];

    installPhase = ''
      install -Dm755 zeron $out/bin/zeron
      install -Dm644 zeron.desktop $out/share/applications/zeron.desktop
      install -Dm644 zeron.png $out/share/icons/hicolor/1024x1024/apps/zeron.png
    '';
  };
in
{
  home.packages = [ zeron ];
}

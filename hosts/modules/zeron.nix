{ pkgs, ... }:

let
  # Built from our fork (~/dev/zeron: upstream + nested-repo diffs). To update:
  # rebase the fork onto upstream, commit, then bump `rev` here.
  # ponytail: local path only exists on simpc; push the fork to GitHub for simbook.
  src = builtins.fetchGit {
    url = "/home/simrat39/dev/zeron";
    rev = "4c1f18c452a43fc6c151d11a79a90399b9fa5e5a";
  };
  zeron = pkgs.rustPlatform.buildRustPackage {
    pname = "zeron";
    version = (builtins.fromTOML (builtins.readFile "${src}/Cargo.toml")).workspace.package.version;
    inherit src;
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      allowBuiltinFetchGit = true; # git deps (gpui fork etc.) are pinned by rev in Cargo.lock
    };
    cargoBuildFlags = [ "-p" "zeron" ];
    doCheck = false; # the full suite is huge; the fork's own test runs in the dev shell

    nativeBuildInputs = with pkgs; [ pkg-config cmake perl rustPlatform.bindgenHook autoPatchelfHook wrapGAppsHook3 ];
    buildInputs = with pkgs; [
      openssl sqlite zstd zlib alsa-lib fontconfig freetype
      libxkbcommon wayland libxcb libx11
      glib gtk3 webkitgtk_4_1 libsoup_3 json-glib onnxruntime
    ];
    # ort-sys would otherwise download onnxruntime at build time
    ORT_LIB_PATH = "${pkgs.onnxruntime}/lib";
    ORT_LIB_LOCATION = "${pkgs.onnxruntime}/lib";
    ORT_PREFER_DYNAMIC_LINK = "1";
    # dlopen'd at runtime, not in DT_NEEDED
    runtimeDependencies = with pkgs; [ vulkan-loader wayland libxkbcommon libGL webkitgtk_4_1 ];

    postInstall = ''
      install -Dm644 dist/zeron.desktop $out/share/applications/zeron.desktop
      install -Dm644 dist/zeron.png $out/share/icons/hicolor/1024x1024/apps/zeron.png
    '';
  };
in
{
  home.packages = [ zeron ];
}

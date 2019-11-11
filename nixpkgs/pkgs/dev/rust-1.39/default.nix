{ pkgs,
  stdenv ? pkgs.stdenv,
  mkDerivation ? stdenv.mkDerivation,
  fetchurl ? pkgs.fetchurl,
  patchelf ? pkgs.patchelf }:
mkDerivation rec {
    ver = "1.39.0";
    name = "rust-${ver}";
    platform = if stdenv.system == "x86_64-linux" then "x86_64-unknown-linux-gnu"
        else abort "unsupported platform";
    pkgSha = if stdenv.system == "x86_64-linux" then "b10a73e5ba90034fe51f0f02cb78f297ed3880deb7d3738aa09dc5a4d9704a25"
        else abort "unsupported platform";

    buildInputs = [ patchelf ];

    src = fetchurl {
        url = "https://static.rust-lang.org/dist/rust-${ver}-${platform}.tar.gz";
        sha256 = pkgSha;
    };

    phases = ["unpackPhase" "installPhase" "postInstallPhase" ];
    installPhase = ''
        patchShebangs .
        mkdir -p $out
        ./install.sh --prefix=$out
        '';

    postInstallPhase = ''
        patchShebangs $out

        if [ "${stdenv.system}" = "x86_64-linux" ]; then
          interp="$(cat $NIX_CC/nix-support/dynamic-linker)"
          patchelf --set-interpreter $interp $out/bin/rustc
          patchelf --set-interpreter $interp $out/bin/rustdoc
          patchelf --set-interpreter $interp $out/bin/cargo
          patchelf --set-interpreter $interp $out/bin/rustfmt
        fi
        '';
}

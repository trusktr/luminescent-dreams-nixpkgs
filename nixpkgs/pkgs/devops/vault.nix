{ fetchurl, unzip, stdenv }:
let
  ver = "1.0.1";
  package = if stdenv.system == "x86_64-linux" then "vault_${ver}_linux_amd64.zip"
    else if stdenv.system == "x86_64-darwin" then "vault_${ver}_darwin_amd64.zip"
    else abort "unsupported platform";
  checksum = if stdenv.system == "x86_64-linux" then "1ea02627d0157dc844012995123f1cde86a02cb3b45030a9526057d12ee8d924"
    else if stdenv.system == "x86_64-darwin" then "10c1c3a0071dc0d50c2751027def3a0011a003e573bb9586cb34b7dee32e3d6d"
    else abort "unsupported platform";

in stdenv.mkDerivation rec {
  name = "vault-${version}";
  version = ver;

  buildCommand = ''
  mkdir -p $out/bin
  unzip $src
  mv vault $out/bin/vault
  echo Installed vault to $out/bin/vault
  '';

  src = fetchurl {
    url = "https://releases.hashicorp.com/vault/${version}/${package}";
    sha256 = checksum;
    name = package;
  };

  buildInputs = [ unzip ];
}

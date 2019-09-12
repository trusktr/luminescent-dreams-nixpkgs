{ fetchurl, unzip, stdenv }:
let
    ver = "1.1.3";
    package = if stdenv.system == "x86_64-linux" then "packer_${ver}_linux_amd64.zip"
         else if stdenv.system == "x86_64-darwin" then "packer_${ver}_darwin_amd64.zip"
         else abort "unsupported platform";
    checksum = if stdenv.system == "x86_64-linux" then "b7982986992190ae50ab2feb310cb003a2ec9c5dcba19aa8b1ebb0d120e8686f"
          else if stdenv.system == "x86_64-darwin" then "b8ca17aedfbbb8607066528631d4f5992746fe9b2ec1bbc8d33fd1e5c196cd2c"
          else abort "unsupported platform";

in stdenv.mkDerivation rec {
  name = "packer-${version}";
  version = ver;

  buildCommand = ''
  mkdir -p $out/bin
  unzip $src
  mv packer $out/bin/packer
  echo Installed packer to $out/bin/packer
  '';

  src = fetchurl {
    url = "https://releases.hashicorp.com/packer/${version}/${package}";
    sha256 = checksum;
    name = package;
  };

  buildInputs = [ unzip ];
}

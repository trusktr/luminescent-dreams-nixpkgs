{ fetchurl, unzip, stdenv }:
let
    ver = "0.12.2";
    package = if stdenv.system == "x86_64-linux" then "terraform_${ver}_linux_amd64.zip"
         else if stdenv.system == "x86_64-darwin" then "terraform_${ver}_darwin_amd64.zip"
         else abort "unsupported platform";
    checksum = if stdenv.system == "x86_64-linux" then "d9a96b646420d7f0a80aa5d51bb7b2a125acead537ab13c635f76668de9b8e32"
          else if stdenv.system == "x86_64-darwin" then "f0cc23bc6ec1a5adc4043108ff5c79c2bddcdc70b056bd207defca1ae386d477"
          else abort "unsupported platform";

in stdenv.mkDerivation rec {
  name = "terraform-${version}";
  version = ver;

  buildCommand = ''
  mkdir -p $out/bin
  unzip $src
  mv terraform $out/bin/terraform
  echo Installed terraform to $out/bin/terraform
  '';

  src = pkgs.fetchurl {
    url = "https://releases.hashicorp.com/terraform/${version}/${package}";
    sha256 = checksum;
    name = package;
  };

  buildInputs = [ pkgs.unzip ];
}

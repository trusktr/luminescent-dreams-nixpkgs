{ system ? builtins.currentSystem }:
let
  pkgs = import <nixpkgs> { inherit system; };
  self = {
    rust_1_33_0 = pkgs.callPackage ./pkgs/dev/rust-1.33 {
      inherit pkgs;
    };

    nodejs_9_10_0 = pkgs.callPackage ./pkgs/dev/node9.nix {
      inherit pkgs;
    };

    nodejs_10_15_3 = pkgs.callPackage ./pkgs/dev/node10.nix {
      inherit pkgs;
    };

    ansible_2_7_4 = pkgs.callPackage ./pkgs/devops/ansible.nix {
      inherit (pkgs) stdenv fetchurl pythonPackages;
    };

    certbot_0_19_0 = pkgs.callPackage ./pkgs/devops/certbot.nix {
      inherit (pkgs) stdenv python2Packages fetchFromGitHub dialog;
    };

    packer_1_1_3 = pkgs.callPackage ./pkgs/devops/packer.nix {
      inherit (pkgs) fetchurl unzip stdenv;
    };

    terraform_0_12_2 = pkgs.callPackage ./pkgs/devops/terraform.nix {
      inherit (pkgs) fetchurl unzip stdenv;
    };

    vault_1_0_1 = pkgs.callPackage ./pkgs/devops/vault.nix {
      inherit (pkgs) fetchurl unzip stdenv;
    };
  };
in self

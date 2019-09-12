{ pkgs, ld, fetchFromGitHub }:
let src = fetchFromGitHub {
        owner = "luminescent-dreams";
        repo = "fitnesstrax";
        rev = "f19a73a6726e5ae81c4e606476d89efe44b79b6f";
        sha256 = "0wd8shk1hf72zyrcvi317ffd4krs725k0slzhzrllghcvspzx19f";
    };
in import "${src}/default.nix" { inherit pkgs ld; }

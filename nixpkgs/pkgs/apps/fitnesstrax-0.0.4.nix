{ pkgs, ld }:
let src = pkgs.fetchFromGitHub {
        owner = "luminescent-dreams";
        repo = "fitnesstrax";
        rev = "20f330b773c9781cdaf2a7189a31103c97160730";
        sha256 = "1b7a9d2j60myg22qbxywkjrmidzca0yg0rzaxjph2jdq29267gk7";
    };
in pkgs.callPackage "${src}/default.nix" { inherit pkgs ld; }

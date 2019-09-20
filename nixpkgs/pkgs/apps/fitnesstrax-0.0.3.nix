{ pkgs, ld }:
let src = pkgs.fetchFromGitHub {
        owner = "luminescent-dreams";
        repo = "fitnesstrax";
        rev = "1daa6c8559488a2d0b62ff04c53daf4dcc2f23c1";
        sha256 = "1ivck9i5dikgm8xjbh1da5ij9w505gmnbwr8vcrn7r6nf7pj8rqj";
    };
in pkgs.callPackage "${src}/default.nix" { inherit pkgs ld; }

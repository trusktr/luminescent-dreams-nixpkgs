{ pkgs, fetchFromGitHub }:
let src = fetchFromGitHub {
        owner = "luminescent-dreams";
        repo = "fitnesstrax";
        rev = "85fee1ffa9827eb025628804cd4614625f368180";
        sha256 = "0hsfs76kylfbp1bp309rsj669ygwqwyrkqf76f4m7h8fshqgsl1k";
    };
in import "${src}/default.nix" { inherit pkgs; }

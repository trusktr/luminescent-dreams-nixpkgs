# How to use:

This is supposed to be a proper Nix channel. However, actually adding it to my channel list basically breaks all of my channels.

At this time, I simply use this by keeping a clone of the repository on my local machine, and then importing the top level expression. This is a snippet from my [config.nix](https://github.com/savannidgerinel/nix-shell/blob/sol/config.nix) file.

```
let
    unstable = import <nixpkgs> {};
    ld = import /Users/savanni/src/luminescent-dreams/luminescent-dreams-nixpkgs/nixpkgs/default.nix {};
in {
  packageOverrides = pkgs: {
    all = pkgs.buildEnv {
      name = "all";
      paths = [
        unstable.wget
        ...
        ld.nodejs_10_15_3
        ...
      ]
  }
}
```

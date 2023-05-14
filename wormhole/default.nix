{ pkgs ? import ../nixpkgs.nix { } }:
let
  # Call our lib to build the image
  output = pkgs.callPackage ../nix/lib/docker-image.nix {
    pname = "magic-wormhole";
    iname = "leastauthority/wormhole";
    config = {
      WorkingDir = "/app";
      EntryPoint = [
        "wormhole"
      ];
    };
  };
in output

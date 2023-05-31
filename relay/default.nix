{ pkgs ? import ../nixpkgs.nix { } }:
let
  output = pkgs.callPackage ../nix/lib/docker-image.nix {
    pname = "magic-wormhole-transit-relay";
    iname = "leastauthority/magic-wormhole-relay";
    config = {
      WorkingDir = "/app";
      Volumes = { "/db" = { }; };
      Cmd = [
        "twist"
        "transitrelay"
        "--usage-db=/db/usage-transitrelay.sqlite"
        "--blur-usage=3600"
        "--port=tcp:4001"
        "--websocket=tcp:4002"
      ];
    };
  };
in output

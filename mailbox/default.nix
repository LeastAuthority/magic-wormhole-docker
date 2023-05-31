{ pkgs ? import ../nixpkgs.nix { } }:
let
  # Call our lib to build the image
  output = pkgs.callPackage ../nix/lib/docker-image.nix {
    pname = "magic-wormhole-mailbox-server";
    iname = "leastauthority/magic-wormhole-mailbox";
    config = {
      WorkingDir = "/app";
      Volumes = { "/db" = { }; };
      Cmd = [
        "twist"
        "wormhole-mailbox"
        "--usage-db=/db/usage-relay.sqlite"
        "--blur-usage=3600"
        "--channel-db=/db/relay.sqlite"
      ];
    };
  };
in output

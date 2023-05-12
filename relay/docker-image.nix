{ dockerTools, python3 }:
let
  # Inject mailbox in the standard Python env
  pyenv = python3.buildEnv.override {
    extraLibs = [ python3.pkgs.magic-wormhole-transit-relay ];
    ignoreCollisions = true;
  };
in
# Build the image with our custom CMD
dockerTools.buildLayeredImage {
  name = "magic-wormhole-relay";
  config = {
    WorkingDir = "/app";
    Volumes = { "/db" = { }; };
    Cmd = [
      "twist transitrelay"
      "--usage-db=/db/usage-transitrelay.sqlite"
      "--blur-usage=3600"
      "--port=tcp:4001"
      "--websocket=tcp:4002"
    ];
  };
  contents = [ pyenv ];
}

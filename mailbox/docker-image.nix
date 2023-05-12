{ dockerTools, python3 }:
let
  # Inject mailbox in the standard Python env
  pyenv = python3.buildEnv.override {
    extraLibs = [ python3.pkgs.magic-wormhole-mailbox-server ];
    ignoreCollisions = true;
  };
in
# Build the image with our custom CMD
dockerTools.buildLayeredImage {
  name = "magic-wormhole-mailbox";
  config = {
    WorkingDir = "/app";
    Volumes = { "/db" = { }; };
    Cmd = [
      "twist wormhole-mailbox"
      "--usage-db=/db/usage-relay.sqlite"
      "--blur-usage=3600"
      "--channel-db=/db/relay.sqlite"
    ];
  };
  contents = [ pyenv ];
}

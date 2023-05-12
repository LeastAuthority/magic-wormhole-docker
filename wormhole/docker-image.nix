{ dockerTools, python3 }:
let
  # Inject mailbox in the standard Python env
  pyenv = python3.buildEnv.override {
    extraLibs = [ python3.pkgs.magic-wormhole ];
    ignoreCollisions = true;
  };
in
# Build the image with our custom CMD
dockerTools.buildLayeredImage {
  name = "magic-wormhole";
  config = {
    WorkingDir = "/app";
    EntryPoint = [
      "wormhole"
    ];
  };
  contents = [ pyenv ];
}

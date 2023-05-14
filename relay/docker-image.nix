{ dockerTools, python3, lib }:
let
  pname = "magic-wormhole-transit-relay";
  # Inject mailbox in the standard Python env
  pyenv = python3.buildEnv.override {
    extraLibs = [ python3.pkgs.${pname} ];
    ignoreCollisions = true;
  };
  ver = {
    py = lib.concatStringsSep "" ( lib.lists.sublist 0 2 ( lib.strings.splitString "." python3.version ) );
    pkg = python3.pkgs.${pname}.version;
    nix = lib.concatStringsSep "" ( lib.lists.sublist 0 2 ( lib.strings.splitString "." lib.version ) );
  };
in
# Build the image with our custom CMD
dockerTools.buildLayeredImage {
  name = pname;
  tag = "${ver.pkg}-python${ver.py}-nix${ver.nix}";
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
  contents = [ pyenv ];
}
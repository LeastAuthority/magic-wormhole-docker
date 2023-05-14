{ dockerTools, python3, lib }:
let
  pname = "magic-wormhole-mailbox-server";
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
      "wormhole-mailbox"
      "--usage-db=/db/usage-relay.sqlite"
      "--blur-usage=3600"
      "--channel-db=/db/relay.sqlite"
    ];
  };
  contents = [ pyenv ];
}

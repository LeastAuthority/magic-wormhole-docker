{ dockerTools, python3, lib, pname, iname ? pname, config ? {} }:
let
  # Inject mailbox in the standard Python env
  pyenv = python3.buildEnv.override {
    extraLibs = [ python3.pkgs.${pname} ];
    ignoreCollisions = true;
  };
  # Parse Python package and NixOS versions to tag the image
  pkgVersion = python3.pkgs.${pname}.version;
  libVersion = lib.lists.flatten (lib.lists.sublist 1 1 (builtins.split "([^.]+)\.([^.]+)\.([^.]+)\.([^.]+)" lib.version));
  nixVersion = builtins.concatStringsSep "." (lib.lists.take 3 libVersion);
in
# Build the image with our custom CMD
dockerTools.buildLayeredImage {
  name = iname;
  tag = "${pkgVersion}-nixos-${nixVersion}";
  config = config;
  contents = [ pyenv ];
}

{ pkgs ? import ./nixpkgs.nix { } }:
{
  # Build our Docker images
  mailbox = pkgs.callPackage ./mailbox { };
  relay = pkgs.callPackage ./relay { };
  wormhole = pkgs.callPackage ./wormhole { };
}

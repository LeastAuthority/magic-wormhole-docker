{ pkgs ? import ./nixpkgs.nix { } }:
{
  mailbox = pkgs.callPackage ./mailbox/docker-image.nix { };
  relay = pkgs.callPackage ./relay/docker-image.nix { };
  wormhole = pkgs.callPackage ./wormhole/docker-image.nix { };
}

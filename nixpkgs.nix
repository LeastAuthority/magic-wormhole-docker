# Import local nixpkg.json which pins all our Nix packages
import (builtins.fetchTarball (builtins.fromJSON (builtins.readFile ./nixpkgs.json)))

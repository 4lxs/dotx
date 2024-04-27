{ lib }:
with lib;
/**
  returns a list of all modules for a given target (home, nixos, darwin)
*/
target:
builtins.filter builtins.pathExists (
  mapAttrsToList (file: kind: ../modules + "/${file}/${target}.nix") (builtins.readDir ../modules)
)

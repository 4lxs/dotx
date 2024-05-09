{flake-parts, ...} @ inputs:
/*
*
function that returns a nixos module that imports all dotx modules for the
target given as argument

file structure is expected to be:
../modules/** /<module>/<target>.nix
<module> is anything (usually name of the module) that contains one of
the possible targets (home.nix, nixos.nix, darwin.nix)
<target> is the target (home, nixos, darwin)
*/
target: {lib, ...}:
with lib; let
  exists = builtins.pathExists;
  scandir = path:
    mapAttrsToList (
      filename: kind: let
        f = path + "/${filename}";
      in
        assert asserts.assertMsg (kind == "directory") "expected a target in parent of ${f}";
          if (exists "${f}/home.nix") || (exists "${f}/nixos.nix") || (exists "${f}/darwin.nix")
          then f + "/${target}.nix"
          else scandir f
    ) (builtins.readDir path);
  modules = builtins.filter builtins.pathExists (lib.lists.flatten (scandir ../modules));
in {
  imports = builtins.map (m: flake-parts.lib.importApply m inputs) modules;
}

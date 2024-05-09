is_main_system: {flake-parts, ...} @ inputs:
/*
function that returns a nixos module that imports all dotx modules for the
target given as argument

file structure is expected to be:
../modules/** /<module>/<target>.nix
<module> is anything (usually name of the module) that contains one of
the possible targets (home.nix, nixos.nix, darwin.nix)
<target> is the target (home, nixos, darwin)
<target> can also be main. in this case the module will be imported if module
is nixos on nixos, darwin with nix-darwin, or home on standalone home-manager
*/
target: {lib, ...}:
with lib; let
  exists = builtins.pathExists;
  possible_targets = ["home" "nixos" "darwin" "main"];
  scandir = path:
    mapAttrsToList (
      filename: kind: let
        f = path + "/${filename}";
      in
        assert asserts.assertMsg (kind == "directory") "expected a target in parent of ${f}";
          if lists.any (t: exists "${f}/${t}.nix") possible_targets
          then [(f + "/${target}.nix")] ++ lists.optional is_main_system (f + "/main.nix")
          else scandir f
    ) (builtins.readDir path);
  modules = builtins.filter (x: builtins.pathExists x) (lib.lists.flatten (scandir ../modules));
in {
  imports = builtins.map (m: flake-parts.lib.importApply m inputs) modules;
}

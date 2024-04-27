{ lib, ... }:
with lib;
let
  themes = builtins.attrNames (builtins.readDir ./themes);
in
{
  imports = [ ./colors.nix ] ++ (builtins.map (name: ./themes + "/${name}") themes);

  options.dotx.theme = {
    fallback = mkOption {
      type = types.enum themes;
      default = "svl";
    };
    font = mkOption {
      type = types.submodule {
        options = {
          name = mkOption { type = types.str; };
          package = mkOption { type = types.package; };
        };
      };
    };
  };
}

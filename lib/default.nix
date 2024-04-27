{ base16, ... }@inputs:
{ pkgs, lib, ... }:
with lib;
{
  _module.args.libx = {
    mkEnableTarget =
      name:
      mkOption {
        description = "enable target ${name}";
        type = types.bool;
        default = false;
      };
    base16 = pkgs.callPackage base16.lib inputs;
    templates = import ./templates.nix inputs;
  };
}

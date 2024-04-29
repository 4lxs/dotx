inputs:
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  _module.args.libx = rec {
    mkTargetIf =
      default: description:
      mkOption {
        type = types.bool;
        inherit default description;
      };
    mkEnableTarget = mkTargetIf false;
    mkDisableTarget = mkTargetIf true;

    base16 = pkgs.callPackage inputs.base16.lib inputs;
    templates = import ./templates.nix inputs;
  };
}

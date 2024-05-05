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
    mkBoolOption =
      default: description:
      mkOption {
        type = types.bool;
        inherit default description;
      };
    mkEnableOption = mkBoolOption false;
    mkDisableOption = mkBoolOption true;
    mkTargetOptionIf = default: description: { enable = mkBoolOption default description; };
    mkTargetOption = mkTargetOptionIf false;

    mkConfigOption = name: mkTargetOptionIf (config.dotx.config == "${name}");

    base16 = pkgs.callPackage inputs.base16.lib inputs;
    templates = import ./templates.nix inputs;
  };
}

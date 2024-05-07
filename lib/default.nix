inputs:
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config.lib.dotx = rec {
    mkBoolOption =
      default: description:
      mkOption {
        type = types.bool;
        inherit default description;
      };
    mkEnableOption = mkBoolOption false;
    mkDisableOption = mkBoolOption true;
    mkTargetOptionDef = default: description: { enable = mkBoolOption default description; };
    mkTargetOption = mkTargetOptionDef false;

    mkConfigOption = name: mkTargetOptionDef (config.dotx.config == "${name}");

    base16 = pkgs.callPackage inputs.base16.lib inputs;
    templates = import ./templates.nix inputs;
  };
}

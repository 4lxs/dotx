inputs: {
  config,
  pkgs,
  lib,
  ...
} @ args:
with lib; {
  config.lib.dotx = rec {
    mkBoolOption = default: description:
      mkOption {
        type = types.bool;
        inherit default description;
      };
    mkEnableOption = mkBoolOption false;
    mkDisableOption = mkBoolOption true;
    mkTargetOptionDef = default: description: {enable = mkBoolOption default description;};
    mkTargetOption = mkTargetOptionDef false;

    mkConfigOption = name: mkTargetOptionDef (cfg.config == "${name}");

    base16 = pkgs.callPackage inputs.base16.lib inputs;
    templates = import ./templates.nix inputs;
    cfg =
      if args ? "osConfig" && args.osConfig ? "dotx"
      then args.osConfig.dotx
      else config.dotx;
  };
}

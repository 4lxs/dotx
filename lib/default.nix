inputs: {
  config,
  pkgs,
  lib,
  ...
} @ args:
with lib; {
  config.lib.dotx = rec {
    options = rec {
      mkBool = default: description:
        mkOption {
          type = types.bool;
          inherit default description;
        };
      mkEnable = mkBool false;
      mkDisable = mkBool true;
      mkTargetDef = default: description: {enable = mkBool default description;};
      mkTarget = mkTargetDef false;
      mkConfig = name: mkTargetDef (cfg.config == "${name}");
    };

    base16 = pkgs.callPackage inputs.base16.lib inputs;
    templates = import ./templates.nix inputs;
    cfg =
      if args ? "osConfig" && args.osConfig ? "dotx"
      then args.osConfig.dotx
      else config.dotx;
  };
}

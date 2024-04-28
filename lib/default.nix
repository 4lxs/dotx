{ base16, ... }@inputs:
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  _module.args.libx = {
    mkEnableTarget =
      name:
      mkOption {
        description = "enable target ${name}";
        type = types.bool;
        default = config.dotx.autoEnable;
      };
    base16 = pkgs.callPackage base16.lib inputs;
    templates = import ./templates.nix inputs;
  };
}

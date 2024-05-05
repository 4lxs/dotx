_inputs:
{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.fish = libx.mkTargetOption "fish shell";

  config = mkIf config.dotx.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}

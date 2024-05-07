_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.fish = libx.mkTargetOption "fish shell";

  config = mkIf config.dotx.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}

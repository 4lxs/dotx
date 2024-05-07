_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.starship = libx.mkTargetOption "starship prompt";

  config = mkIf config.dotx.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}

_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.kdeconnect = libx.mkTargetOption "kdeconnect";

  config = mkIf config.dotx.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

_inputs:
{ config, lib, ... }:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.kdeconnect = libx.mkTargetOption "kdeconnect";

  config = mkIf config.dotx.kdeconnect.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}

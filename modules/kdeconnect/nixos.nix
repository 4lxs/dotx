_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.kdeconnect.enable {
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

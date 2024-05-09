_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

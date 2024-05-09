_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}

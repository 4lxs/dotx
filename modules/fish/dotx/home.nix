_inputs: {
  config,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkIf libx.cfg.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}

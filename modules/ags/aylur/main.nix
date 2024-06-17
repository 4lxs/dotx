{self, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
  inherit (self.packages.${pkgs.system}) asztal;
in {
  config = lib.mkIf libx.cfg.ags.aylur.enable {
    dotx.launcher = "${asztal}/bin/asztal --toggle-window launcher";
  };
}

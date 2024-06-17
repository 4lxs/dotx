{
  self,
  aylur,
  matugen,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
  inherit (self.packages.${pkgs.system}) asztal;
in {
  config = lib.mkIf libx.cfg.ags.aylur.enable {
    home.packages = [asztal];
    programs.astal = {
      enable = true;
      extraPackages = [pkgs.libadwaita];
    };

    programs.ags = {
      enable = true;
      configDir = aylur + "/ags";
      extraPackages = [pkgs.accountsservice];
    };
  };
}

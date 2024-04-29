{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.ags.enable = libx.mkEnableTarget "aylur's gtk shell";

  # TODO: nixos services.upower
  config = mkIf config.dotx.ags.enable {
    programs.ags = {
      enable = true;
    };
  };
}

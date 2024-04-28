{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.starship.enable = libx.mkEnableTarget "starship prompt";

  config = mkIf config.dotx.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}

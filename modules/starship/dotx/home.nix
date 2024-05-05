_inputs:
{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.starship = libx.mkTargetOption "starship prompt";

  config = mkIf config.dotx.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}

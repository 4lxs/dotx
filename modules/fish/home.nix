{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx.fish.enable = libx.mkEnableTarget "fish shell";

  config = mkIf config.dotx.fish.enable {
    programs.fish = {
      enable = true;
    };
  };
}

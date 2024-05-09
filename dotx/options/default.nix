{
  lib,
  config,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  imports = [
    ./theme
    ./modules.nix
  ];

  options.dotx = {
  };
}

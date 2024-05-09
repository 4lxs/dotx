{
  lib,
  config,
  options,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  configs = builtins.attrNames options.dotx.configs;
in {
  imports = [
    ./theme
    ./modules.nix
  ];

  options.dotx = {
    config = mkOption {type = types.enum (configs ++ ["clean"]);};
  };
}

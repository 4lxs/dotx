{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  imports = [
    ./theme
    ./system
  ];
  options.dotx = {
    autoEnable = mkOption {
      type = types.bool;
      description = ''
        automatically enable relevant modules for your dotx configuration
      '';
    };
  };
}

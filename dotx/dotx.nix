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
    ./configuration
  ];
  options.dotx = { };
}

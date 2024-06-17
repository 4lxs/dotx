{
  config,
  options,
  ...
}: let
  libx = config.lib.dotx;
  configs = builtins.attrNames options.dotx.configs;
in {
  imports = [
    ./theme
    ./modules.nix
  ];

  options.dotx = let
    inherit (libx.options) mkStr mkEnum;
  in {
    config = mkEnum (configs ++ ["clean"]) ''
      The configuration to use
    '';

    editor = mkStr ''
      command to execute the editor.
      should probably be a nix store path
    '';

    launcher = mkStr ''
      command to toggle the launcher
    '';

    user = {
      name = mkStr ''
        name for profiles. (user, git, firefox, ...)
      '';
      email = mkStr ''
        email for profiles. (git, ...)
      '';
    };
  };
}

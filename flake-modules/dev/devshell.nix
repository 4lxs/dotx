{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devshells.default = {
      devshell.startup.pre-commit.text = config.pre-commit.installationScript;

      packages = with pkgs; [convco alejandra];

      commands = [
        {
          name = "format";
          help = "format the codebase";
          command = "nix fmt";
        }
      ];
    };
  };
}

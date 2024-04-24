{ inputs, ... }:
{
  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-rfc-style;

      devshells.default = {
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

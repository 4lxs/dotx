{
  description = "dotx configuration flake";

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [./flake-modules];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      flake = {
        nixosModules.dotx = {
          imports = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix true inputs) "nixos")
            ./dotx/dotx.nix
          ];
          # TODO: make optional
          home-manager.sharedModules = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix false inputs) "home")
          ];
        };
        homeManagerModules.dotx = {
          imports = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix true inputs) "home")
            ./dotx/dotx.nix
          ];
        };
        # TODO
        # nixDarwinModules.dotx = {
        #   imports = [ ./dotx/nix-darwin ];
        # };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    astal.url = "github:Aylur/astal";
    aylur.url = "github:Aylur/dotfiles";

    base16.url = "github:SenchoPens/base16.nix";
    base16-kitty = {
      url = "github:kdrag0n/base16-kitty";
      flake = false;
    };
  };
}

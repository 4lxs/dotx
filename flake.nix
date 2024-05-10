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
            ./dotx/options
          ];
          # TODO: make optional
          home-manager.sharedModules = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix false inputs) "home")
            (import ./dotx/homeImports.nix inputs)
          ];
        };
        homeManagerModules.dotx = {
          imports = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix true inputs) "home")
            ./dotx/options
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
    end4 = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };

    base16.url = "github:SenchoPens/base16.nix";
    base16-kitty = {
      url = "github:kdrag0n/base16-kitty";
      flake = false;
    };
  };
}

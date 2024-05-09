{
  astal,
  ags,
  matugen,
  aylur,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  imports = [
    astal.homeManagerModules.default
    ags.homeManagerModules.default
  ];

  config = mkIf libx.cfg.ags.enable {
    programs.astal = {
      enable = true;
      extraPackages = with pkgs; [libadwaita];
    };

    programs.ags = {
      enable = true;
      configDir = aylur + "/ags";
      extraPackages = with pkgs; [accountsservice];
    };

    home.packages = with pkgs; [
      bun
      dart-sass
      fd
      brightnessctl
      swww
      matugen.packages.${system}.default
      slurp
      wf-recorder
      wl-clipboard
      wayshot
      swappy
      hyprpicker
      pavucontrol
      networkmanager
      gtk3
    ];
  };
}

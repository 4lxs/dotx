{
  astal,
  ags,
  matugen,
  ...
}:
{
  config,
  lib,
  libx,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    astal.homeManagerModules.default
    ags.homeManagerModules.default
  ];

  options.dotx.ags = libx.mkTargetOption ''
    ags widgets from [aylur's dotfiles](https://github.com/Aylur/dotfiles/tree/main)
  '';

  config = mkIf config.dotx.ags.enable {

    programs.astal = {
      enable = true;
      extraPackages = with pkgs; [ libadwaita ];
    };

    programs.ags = {
      enable = true;
      configDir = ./cfg;
      extraPackages = with pkgs; [ accountsservice ];
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

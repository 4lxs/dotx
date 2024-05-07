_inputs:
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  libx = config.lib.dotx;
in
{
  options.dotx.hyprland = libx.mkTargetOption "hyprland window manager";

  config = mkIf config.dotx.hyprland.enable {
    home.packages = with pkgs; [
      brightnessctl
      qt6.qtwayland
      wl-clipboard
      cliphist
      libnotify
      libsForQt5.polkit-kde-agent

      # acpi
    ];

    # programs.hyprlock = {
    #   enable = true;
    #   backgrounds = [ { path = "${./background.png}"; } ];
    # };

    services = {
      # udiskie.enable = true;
      playerctld.enable = true;
      blueman-applet.enable = true;
      mpris-proxy.enable = true;
      network-manager-applet.enable = true;
      syncthing = {
        enable = true;
        # doesn't work currently. no clue why
        # tray = {
        #   enable = true;
        # };
      };
    };

    home.file.".local/bin/cliphist-rofi".source = ./scripts/cliphist-rofi;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      extraConfig =
        with pkgs;
        builtins.readFile (substituteAll {
          src = ./hyprland.conf;
          inherit swaybg;
          inherit (config.dotx.theme) wallpaper;
          polkit = libsForQt5.polkit-kde-agent;
          keymap = "${./keymap.xkb}";
        });
    };
  };
}

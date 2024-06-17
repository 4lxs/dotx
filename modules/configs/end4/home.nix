{
  anyrun,
  end4,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  libx = config.lib.dotx;
in {
  /*
  didn't add fontconfig. don't know what it does

  stuff to add: TODO
  microtex, (https://github.com/NanoMichael/MicroTeX.git)
  oneui icon theme, (https://github.com/end-4/OneUI4-Icons.git)
  gabarito, (https://github.com/naipefoundry/gabarito.git)

  */
  config = lib.mkIf libx.cfg.configs.end4.enable {
    home.packages = [
      # installers
      pkgs.bibata-cursors

      # see https://github.com/end-4/dots-hyprland/blob/main/scriptdata/dependencies.conf
      # some of them are already in ags/end-4

      ### Basic
      pkgs.axel
      pkgs.cliphist

      ### Player and Audio
      pkgs.pavucontrol
      pkgs.libdbusmenu
      pkgs.playerctl
      pkgs.swww

      ### GTK
      pkgs.webp-pixbuf-loader
      pkgs.gtk-layer-shell
      pkgs.gtk3
      pkgs.yad
      pkgs.ydotool

      ### Gnome
      pkgs.gnome.gnome-keyring
      pkgs.gnome.gnome-control-center
      pkgs.gammastep

      ### Widgets
      pkgs.hyprlock
      pkgs.hypridle
      pkgs.wlogout
      pkgs.wl-clipboard
      anyrun.packages.${pkgs.system}.anyrun-with-all-plugins

      ### Fonts and Themes
      # fonts are in nixos.nix
      pkgs.adw-gtk3
      pkgs.libsForQt5.qt5ct
      pkgs.fish
      pkgs.starship

      ### Screenshot and Recoder
      pkgs.swappy
      pkgs.wf-recorder
      pkgs.grim
      pkgs.tesseract
      # idk: tesseract-data-eng
    ];
    # TODO: make derivations
    home.file.".local/bin" = {
      source = "${end4}/.local/bin";
      recursive = true;
    };
    xdg.configFile = let
      mkCfg = name: {
        source = end4 + "/.config/${name}";
        recursive = true;
      };
    in {
      "anyrun" = mkCfg "anyrun";
      "fish" = mkCfg "fish";
      "foot" = mkCfg "foot";
      "fuzzel" = mkCfg "fuzzel";
      "hypr/custom" = mkCfg "hypr/custom";
      "hypr/hyprland" = mkCfg "hypr/hyprland";
      "hypr/hyprlock" = mkCfg "hypr/hyprlock";
      "hypr/shaders" = mkCfg "hypr/shaders";
      "hypridle.conf" = mkCfg "hypridle.conf";
      "hyprlock.conf" = mkCfg "hyprlock.conf";
      "mpv" = mkCfg "mpv";
      "qt5ct" = mkCfg "qt5ct";
      "wlogout" = mkCfg "wlogout";
      "zshrc.d" = mkCfg "zshrc.d";
      "starship.toml" = mkCfg "starship.toml";
      "thorium-flags.conf" = mkCfg "thorium-flags.conf";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        exec-once = [
          "ags"
        ];
      };
      extraConfig = builtins.readFile (end4 + "/.config/hypr/hyprland.conf");
    };
  };
}

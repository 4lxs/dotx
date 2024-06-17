{
  self,
  aylur,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
  inherit (self.packages.${pkgs.system}) asztal;
in {
  config = lib.mkIf libx.cfg.hyprland.enable {
    home.packages = with pkgs; [
      brightnessctl
      qt6.qtwayland
      wl-clipboard
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
      # blueman-applet.enable = true;
      mpris-proxy.enable = true;
      network-manager-applet.enable = true;
      syncthing = {
        enable = true;
        # doesn't work currently. no clue why
        # tray = {
        #   enable = true;
        # };
      };
      cliphist.enable = true;
    };

    home.file.".local/bin/cliphist-rofi".source = ./scripts/cliphist-rofi;

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        exec-once = [
          "${asztal}/bin/asztal"
          "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        ];

        monitor = [
          ",preferred,auto,1.25"
        ];

        xwayland.force_zero_scaling = true;

        input = {
          kb_file = "${./keymap.xkb}";

          # touchpad on asahi is too sensitive
          touchpad = {
            tap-to-click = false;
            middle_button_emulation = true;
          };

          follow_mouse = 1;
          sensitivity = -0.1; # -1.0 - 1.0, 0 means no modification.
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = false;
          workspace_swipe_use_r = true;
        };

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 0;
          no_border_on_floating = true;
          layout = "dwindle";
          resize_on_border = true;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
          no_gaps_when_only = 1;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          enable_swallow = true;
          swallow_regex = "^(alacritty)$";
          focus_on_activate = true;
        };

        decoration = {
          rounding = 8;
          # multisample_edges = true;

          active_opacity = 1.0;
          inactive_opacity = 0.95;

          drop_shadow = false;
          shadow_ignore_window = true;
          shadow_offset = "2 2";
          shadow_range = 4;
          shadow_render_power = 2;
          "col.shadow" = "rgba(00000044)";

          # blurls = gtk-layer-shell;
          # # blurls = waybar;
          # blurls = lockscreen;
        };

        animations = {
          enabled = true;
          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
          ];
          animation = [
            "windows, 1, 5, overshot, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "windowsMove, 1, 4, default"
            "border, 1, 10, default"
            "fade, 1, 10, smoothIn"
            "fadeDim, 1, 10, smoothIn"
            "workspaces, 1, 6, default"
          ];
        };

        master = {
          no_gaps_when_only = false;
          mfact = 0.5;
        };

        windowrule = [
          "float, file_progress"
          "float, confirm"
          "float, dialog"
          "float, download"
          "float, notification"
          "float, error"
          "float, splash"
          "float, confirmreset"
          "float, title:Open File"
          "float, title:Open Folder"
          "float, title:branchdialog"
          "float, Lxappearance"
          "float, Rofi"
          "animation none,Rofi"
          "float,viewnior"
          "float,feh"
          "float, pavucontrol-qt"
          "float, pavucontrol"
          "float, file-roller"
          "idleinhibit focus, mpv"
          "idleinhibit fullscreen, firefox"
          "float, title:^(Media viewer)$"
          "float, title:^(Volume Control)$"
          "float, org.kde.polkit-kde-authentication-agent-1"

          "float, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
          "size 800 600, title:^(Volume Control)$"
          "move 75 44%, title:^(Volume Control)$"
          "float, title:^Extension: (Bitwarden - Free Password Manager) - Bitwarden — Mozilla Firefox$"
        ];

        bind = [
          "SUPER, T, exec, alacritty"
          "SUPER, B, exec, firefox"
          "SUPER, L, exec, wlogout"

          # █▀▄▀█ █░█ █░░ ▀█▀ █ █▀▄▀█ █▀▀ █▀▄ █ ▄▀█
          # █░▀░█ █▄█ █▄▄ ░█░ █ █░▀░█ ██▄ █▄▀ █ █▀█
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

          # █▀▄▀█ █ █▀ █▀▀
          # █░▀░█ █ ▄█ █▄▄
          "SUPER, SUPER_L, exec, ${libx.cfg.launcher}"
          "SUPER, V, exec, rofi -modi clipboard:~/.local/bin/cliphist-rofi -show clipboard"
          ", XF86PowerOff, exec, ~/.config/rofi/powermenu/powermenu.sh"

          # lock, exit menu

          # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
          # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░
          "SUPER, Q, killactive,"
          "SUPER SHIFT, Q, exit,"
          "SUPER, M, fullscreen,"
          "SUPER, Space, togglefloating,"
          "SUPER, Return, layoutmsg, swapwithmaster"
          "SUPER, i, layoutmsg, addmaster"
          "SUPER, o, layoutmsg, removemaster"

          # █▀▀ █▀█ █▀▀ █░█ █▀
          # █▀░ █▄█ █▄▄ █▄█ ▄█
          "SUPER, h, movefocus, l"
          "SUPER, l, movefocus, r"
          "SUPER, k, movefocus, u"
          "SUPER, j, movefocus, d"

          # █▀▄▀█ █▀█ █░█ █▀▀
          # █░▀░█ █▄█ ▀▄▀ ██▄
          "SUPER SHIFT, h, movewindow, l"
          "SUPER SHIFT, l, movewindow, r"
          "SUPER SHIFT, k, movewindow, u"
          "SUPER SHIFT, j, movewindow, d"

          # █▀█ █▀▀ █▀ █ ▀█ █▀▀
          # █▀▄ ██▄ ▄█ █ █▄ ██▄
          "SUPER CTRL, h, resizeactive, -20 0"
          "SUPER CTRL, l, resizeactive, 20 0"
          "SUPER CTRL, k, resizeactive, 0 -20"
          "SUPER CTRL, j, resizeactive, 0 20"

          # ▀█▀ ▄▀█ █▄▄ █▄▄ █▀▀ █▀▄
          # ░█░ █▀█ █▄█ █▄█ ██▄ █▄▀
          "SUPER, g, togglegroup"
          "SUPER, tab, changegroupactive"

          # █▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░
          # ▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄
          "SUPER, grave, togglespecialworkspace"
          "SUPER SHIFT, grave, movetoworkspace, special"

          # █▀ █░█░█ █ ▀█▀ █▀▀ █░█
          # ▄█ ▀▄▀▄▀ █ ░█░ █▄▄ █▀█
          "SUPER, A, workspace, 1"
          "SUPER, S, workspace, 2"
          "SUPER, D, workspace, 3"
          "SUPER, F, workspace, 4"
          "SUPER, W, workspace, 5"
          "SUPER, E, workspace, 6"
          "SUPER, R, workspace, 7"

          # █▀▄▀█ █▀█ █░█ █▀▀
          # █░▀░█ █▄█ ▀▄▀ ██▄
          "SUPER SHIFT, A, movetoworkspace, 1"
          "SUPER SHIFT, S, movetoworkspace, 2"
          "SUPER SHIFT, D, movetoworkspace, 3"
          "SUPER SHIFT, F, movetoworkspace, 4"
          "SUPER SHIFT, W, movetoworkspace, 5"
          "SUPER SHIFT, E, movetoworkspace, 6"
          "SUPER SHIFT, R, movetoworkspace, 7"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}

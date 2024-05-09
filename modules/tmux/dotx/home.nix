_inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  libx = config.lib.dotx;
  sessionizer = pkgs.writeScriptBin "tmux-sessionizer.sh" (readFile ./sessionizer.sh);
  sessionizer-sh = "${sessionizer}/bin/tmux-sessionizer.sh";
in {
  config = mkIf libx.cfg.tmux.enable {
    home.packages = with pkgs; [
      gitmux
      fzf
    ];
    xdg.configFile."tmux/gitmux.conf".source = ./gitmux.conf;
    programs.tmux = {
      enable = true;
      mouse = true;
      baseIndex = 1;

      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
        tmuxPlugins.yank
      ];

      extraConfig =
        (readFile ./tmux.conf)
        + ''
          bind t display-popup -w 40% -h 80% -E "${sessionizer-sh}"
          set-option -g default-shell ${pkgs.fish}/bin/fish
        '';
    };
  };
}

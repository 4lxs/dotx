_inputs:
{
  config,
  lib,
  libx,
  pkgs,
  ...
}:
with lib;
let
  sessionizer = pkgs.writeScriptBin "tmux-sessionizer.sh" (readFile ./sessionizer.sh);
  sessionizer-sh = "${sessionizer}/bin/tmux-sessionizer.sh";
in
{
  options.dotx.tmux = libx.mkTargetOption "tmux" // {
    makeTerminalDefault = mkOption {
      type = types.bool;
      description = ''
        make terminals open tmux by default and add a special no tmux desktop entry
        for special cases
      '';
    };
  };

  config = mkIf config.dotx.tmux.enable {
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

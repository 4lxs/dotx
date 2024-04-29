{
  config,
  lib,
  libx,
  ...
}:
with lib;
{
  options.dotx = {
    shell-help.enable = libx.mkEnableTarget "shell help aliases";
    shell-help-git.enable = libx.mkTargetIf config.dotx.shell-help.enable "git help aliases";
  };

  config.home.shellAliases = mkMerge [
    (mkIf config.dotx.shell-help.enable {
      # TODO: doesn't work in fish
      # vi = "\${EDITOR:-nvim}";
      # vim = "\${EDITOR:-nvim}";
      # nvim = "\${EDITOR:-nvim}";
      vi = "nvim";
      vim = "nvim";
      nvim = "nvim";
      emacs = "man nvim";

      # TODO: check if tool exists e.g. [ -x "$(command -v exa)" ]
      ls = "exa -al --color=always --group-directories-first";
      entar = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      grep = "grep --color=auto";
      cat = "bat";
      # TODO: extract

      ".." = "cd ..";
      "..." = "cd ../..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";

      # apt = "man nix-env";
      # apt-get = "man nix-env";
    })
    (mkIf config.dotx.shell-help-git.enable {
      g = "git";
      ga = "git add";
      gs = "git status";
      gc = "git commit";
      gp = "git pull";
      gP = "git push";
      gd = "git diff";
      gl =
        "git log --graph --topo-order --decorate --all --boundary --date=short --abbrev-commit "
        + "--pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
    })
  ];
}

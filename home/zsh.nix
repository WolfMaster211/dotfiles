{ lib, config, ... }: {
  # Allow unfree package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "zsh-abbr" ];

  programs.fzf.enableZshIntegration = true;
  programs.fzf.enableBashIntegration = true;

  programs.zsh = rec {
    enable = true;
    history.size = 10000;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    initContent = "source ~/.zshrc";

    zsh-abbr = {
      enable = true;
      abbreviations = shellAliases;
    };

    shellAliases = let
      path = "~/.config/nixos";
      hostname = "$(cat ${path}/.hostname)";
      notifyDone = "notify-send NixOS Done";
      hms = "nh home switch";
      nhOs = cmd: "sudo true && nh os ${cmd} && ${hms} && ${notifyDone}";
    in {
      n = "nh";
      nos = nhOs "switch";
      noS = "sudo true && nh os switch";
      nou = nhOs "switch --update";
      not = nhOs "test";
      nob = nhOs "build";
      hms = "${hms} && ${notifyDone}";
      hm = "home-manager --flake ${path}#wolfy@${hostname}";
      nr = "nix run nixpkgs#%";

      dots = "dot status";

      src = "exec zsh";
      Bat = "bat --pager='less - mgi - -underline-special - -SILENT'";
      myip = "hostname -i";
      mv = "mv -i";
      ag = "ag --hidden --pager='less -R'";
      rg = "rg --hidden --smart-case";
      fd = "fd --hidden";
      mvc = "mullvad connect";
      mvd = "mullvad disconnect";
      mvr = "mullvad reconnect";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "ael-code/zsh-colored-man-pages"; }
        { name = "mawkler/zsh-bd"; }
        { name = "hlissner/zsh-autopair"; }
        { name = "Aloxaf/fzf-tab"; }
      ];
    };
  };

  # Enable zsh-abbr custom cursor placement
  home.sessionVariables.ABBR_SET_EXPANSION_CURSOR = 1;
}

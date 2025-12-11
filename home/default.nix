{ overlays, inputs, pkgs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./ghostty.nix
    ./zsh.nix
    ./dank-material-shell.nix
    ./vicinae.nix
  ];

  nixpkgs = { inherit overlays; };

  programs = {
    zen-browser.enable = true;

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  services = {
    avizo.enable = true;
    hyprshell = {
      enable = true;
      settings = {
        version = 2;
        windows = {
          switch = {
            switch_workspaces = false;
            modifier = "alt";
          };
        };
      };
    };
  };

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "sioyek-4.desktop";
      "text/plain" = "code.desktop";
      "text/x-shellscript" = "code.desktop";
      "x-scheme-handler/http" = "zen-twilight.desktop";
      "x-scheme-handler/https" = "zen-twilight.desktop";
      "x-scheme-handler/about" = "zen-twilight.desktop";
      "x-scheme-handler/unknown" = "zen-twilight.desktop";
    };
  };

  home = rec {
    username = "wolfy";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
}

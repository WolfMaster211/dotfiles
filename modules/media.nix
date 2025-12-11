{ config, pkgs, lib, ... }:

{

  nixarr = {
    enable = true;
    stateDir = "/nixarr/.state";
  };

  nixarr.jellyfin = {
    enable = true;
    stateDir = "/nixarr.state/jellyfin";
    openFirewall = true;
  };

  nixarr.sonarr = {
    enable = true;
    stateDir = "/nixarr/.state/sonarr";
    openFirewall = true;
  };

  nixarr.prowlarr = {
    enable = true;
    stateDir = "/nixarr/.state/prowlarr";
    openFirewall = true;
  };

  nixarr.recyclarr = {
    enable = true;
    schedule = "weekly";
    stateDir = "/nixarr/.state/recyclarr";

    configuration = {
      sonarr = {
        anime = {
          base_url = "http://localhost:8989";
          api_key = "9f582b88ad9c4629899652618190719d";
          include = [
            { template = "sonarr-quality-definition-anime"; }
            { template = "sonarr-v4-quality-profile-anime"; }
            { template = "sonarr-v4-custom-formats-anime"; }
          ];
          custom_formats = [
            {
              trash_ids = [ "418f50b10f1907201b6cfdf881f467b7" ];
              assign_scores_to = [ { name = "Remux-1080p - Anime"; score = 50; } ];
            }
          ];
        };
      };
    };
  };
}
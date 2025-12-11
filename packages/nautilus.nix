{ config, pkgs, ... }:
{
  programs = {
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };
  };

  services.gnome.sushi.enable = true;
  
  environment.systemPackages = with pkgs; [
    nautilus
    nautilus-python
    nautilus-open-any-terminal
    code-nautilus
  ];
}
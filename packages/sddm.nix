{
  pkgs,
  inputs,
  lib,
  ...
}: let
   # an exhaustive example can be found in flake.nix
   sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
      theme = "rei"; # select the config of your choice
   };
in  {
   # include the test package which can be run using test-sddm-silent
   environment.systemPackages = [sddm-theme sddm-theme.test];
   qt.enable = true;
   services.displayManager.sddm = {
      package = pkgs.kdePackages.sddm; # use qt6 version of sddm
      enable = true;
      wayland.enable = true;
      wayland.compositorCommand = "${lib.getExe' pkgs.kdePackages.kwin "kwin_wayland"} --drm --no-lockscreen --no-global-shortcuts --locale1";
      theme = sddm-theme.pname;
      extraPackages =
            [
              pkgs.kdePackages.layer-shell-qt
            ]
            ++ sddm-theme.propagatedBuildInputs;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
        Theme = {
              CursorTheme = "Bibata-Modern-Ice";
              CursorSize = 24;
            };
      };
   };
}
{ pkgs, inputs, ... }: {
  programs = { hyprland.enable = true; };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

environment.systemPackages = with pkgs; [
  brightnessctl
  xdg-user-dirs xdg-desktop-portal-hyprland
  hyprshot slurp grim wl-clipboard app2unit
  playerctl
  solaar gnomeExtensions.solaar-extension
  (xivlauncher-rb.override { useGameMode = true; })
  vesktop
  kitty qbittorrent
  vscode
  rofi cron
  prismlauncher
  vulkan-tools mangohud steamtinkerlaunch gamescope
  (lutris.override {
    extraPkgs = pkgs: [
      pkgs.wineWowPackages.stagingFull
      pkgs.winetricks
    ];
  })
  winetricks protonup-qt bottles heroic
  wineWowPackages.waylandFull
  ed-odyssey-materials-helper
  bibata-cursors
  fflogs material-icons material-design-icons
  nix-alien nexusmods-app-unfree
  pulseaudio asha-pipewire-sink
  inputs.nix-reshade.packages.${pkgs.pkgs.stdenv.hostPlatform.system}.reshade-full
  inputs.nix-reshade.packages.${pkgs.pkgs.stdenv.hostPlatform.system}.reshade-shaders-full
  inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
  inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
  inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-ge
  inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-osu
  ];
}

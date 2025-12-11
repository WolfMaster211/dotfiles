{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    nur.repos.merrkry.jackify-bin
  ];
}
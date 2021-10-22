{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    gnumake
    go
    goimports
    kubectl
    kubernetes-helm
    wget
  ];
in
{
  config = {
    home.packages = cli-programs;
    home.sessionPath = [
      "/Users/lekva/dev/go/bin"
    ];
  };
}

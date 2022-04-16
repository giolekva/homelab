{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    cmake
    fluxcd
    git
    gnumake
    go
    gocode
    goimports
    gopls
    gnupg
    helmfile
    kubectl
    kubernetes-helm
    python3
    sops
    wget
    zbar
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

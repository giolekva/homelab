{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    rust-analyzer
    nodePackages.typescript-language-server
    # cargo
    rustup
    cmake
    fluxcd
    git
    gnumake
    go
    goimports
    gopls
    gnupg
    helmfile
    jq
    kubectl
    kubernetes-helm
    python3
    sops
    wget
    zbar

    esbuild

    wireguard-tools
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

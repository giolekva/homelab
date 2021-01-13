{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    bazelisk
    goimports
    kube3d
    kubectl
    kubernetes-helm
  ];
in
{
  config = {
    home.packages = cli-programs;
  };
}

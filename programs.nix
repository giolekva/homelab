{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    bazelisk
    goimports
    kubectl
    kubernetes-helm
  ];
in
{
  config = {
    home.packages = cli-programs;
  };
}

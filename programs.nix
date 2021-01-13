{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    bazelisk
    bazel-buildtools
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

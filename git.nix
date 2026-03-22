{ config, pkgs, lib, ... }:

{
  programs.git = lib.mkIf (config.homelab.machine == "headroom") {
    enable = true;
    settings = {
      user.name = "gio";
      user.email = "giorgi@headroom.com";
      github.user = "giolekva";
    };
  };
}

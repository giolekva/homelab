{ config, pkgs, lib, ... }:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
  imports = [
    nur-no-pkgs.repos.rycee.hmModules.emacs-init
    ./bash.nix
    ./emacs.nix
    ./programs.nix
  ];

  home.stateVersion = "21.03";
}

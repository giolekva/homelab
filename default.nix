{ config, pkgs, lib, ... }:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
  imports = [
    nur-no-pkgs.repos.rycee.hmModules.emacs-init
    ./alacritty.nix
    ./bash.nix
    ./emacs.nix
    ./programs.nix
    ./tmux.nix
  ];
}

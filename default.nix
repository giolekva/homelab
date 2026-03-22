{ config, pkgs, lib, ... }:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
  options.homelab.machine = lib.mkOption {
    type = lib.types.str;
    default = "personal";
    description = "Machine identifier (e.g. personal, work)";
  };

  imports = [
    nur-no-pkgs.repos.rycee.hmModules.emacs-init
    ./aerospace.nix
    ./alacritty.nix
    ./bash.nix
    ./emacs.nix
    ./git.nix
    ./programs.nix
    ./tmux.nix
  ];
}

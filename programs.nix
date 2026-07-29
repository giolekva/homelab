{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    alacritty-theme
    clang
    cmake
    go
    gopls
    gnumake
    gnupg
    jq
    k9s
    pi-coding-agent
    pnpm
    python3
    ripgrep
    typescript
    vtsls
    wget
    zbar
  ];
in
{
  config = {
    home.packages = cli-programs;
    home.sessionPath = [
      "$HOME/.npm-global"
    ];
  };
}

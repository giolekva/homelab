{ config, pkgs, lib, ... }:
let
  cli-programs = with pkgs; [
    clang
    cmake
    gnumake
    gnupg
    jq
    python3
    wget
    zbar

    claude-code

    direnv
    pnpm
    nodejs_25
    nodePackages.typescript
    nodePackages.typescript-language-server
    ripgrep
    # tmux

    # ghostty
    alacritty-theme
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

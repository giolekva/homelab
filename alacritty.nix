{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "zenburn";
    settings = {
      terminal.shell = {
        program = "${pkgs.bash}/bin/bash";
        args = ["--login" "-c" "exec ${pkgs.tmux}/bin/tmux new-session -A -s main"];
      };
      window = {
        option_as_alt = "Both";
        decorations = "None";
        startup_mode = "Maximized";
        padding = { x = 2; y = 2; };
      };
      font = {
        size = 12;
        normal = {
          family = "Berkeley Mono";
          style = "Regular";
        };
        bold = {
          family = "Berkeley Mono";
          style = "Bold";
        };
        italic = {
          family = "Berkeley Mono";
          style = "Italic";
        };
      };
    };
  };
}

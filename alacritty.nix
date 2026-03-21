{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "zenburn";
    settings = {
      terminal.shell = {
        program = "${pkgs.bash}/bin/bash";
        args = ["--login"];
      };
      window = {
        option_as_alt = "Both";
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

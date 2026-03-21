{ config, pkgs, ... }:

{
  # Enable the home manager programs option for tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 5000;
    # shell = "${pkgs.zsh}/bin/zsh"; # Replace zsh with your preferred shell package

    extraConfig = ''
      bind r source-file $HOME/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      set-option -g prefix C-t
      unbind C-b
      # bind C-q send-prefix

      # Make splits open in the current directory
      #unbind %
      #bind % split-window -h -c "#{pane_current_path}"
      #unbind '"'
      #bind '"' split-window -v -c "#{pane_current_path}"

      # Reduce escape time for faster key sequence recognition (e.g., for Neovim integration)
      set-option -sg escape-time 10
      set-option -g focus-events on

      set-option -g status-keys emacs
      set-window-option -g mode-keys emacs

      set -g set-clipboard external
    '';
  };
}

{ config, pkgs, ... }:

{
  # Enable the home manager programs option for tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 5000;
    shell = "${pkgs.bash}/bin/bash";

    terminal = "tmux-256color";

    extraConfig = ''
      set -ga terminal-features ",alacritty:RGB"
      bind r source-file $HOME/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      set-option -g prefix C-t
      unbind C-b
      # bind C-q send-prefix

      # Make splits open in the current directory
      unbind %
      bind % split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind '"' split-window -v -c "#{pane_current_path}"

      # Reduce escape time for faster key sequence recognition (e.g., for Neovim integration)
      set-option -sg escape-time 10
      set-option -g focus-events on

      set-option -g status-keys emacs
      set-window-option -g mode-keys emacs

      set -g set-clipboard external

      # macOS clipboard
      bind -T copy-mode M-w send-keys -X copy-pipe-and-cancel "pbcopy"
      bind ] run "pbpaste | tmux load-buffer - ; tmux paste-buffer"

      # Zenburn theme
      set -g status-style 'bg=#3f3f3f,fg=#dcdccc'
      set -g status-left-style 'bg=#1e2320,fg=#88b090'
      set -g status-right-style 'bg=#1e2320,fg=#88b090'
      set -g window-status-current-style 'bg=#1e2320,fg=#f0dfaf,bold'
      set -g window-status-style 'fg=#9fafaf'
      set -g pane-border-style 'fg=#4f4f4f'
      set -g pane-active-border-style 'fg=#7f9f7f'
      set -g message-style 'bg=#3f3f3f,fg=#dcdccc'

      # Seamless navigation with emacs (M-S-hjkl)
      bind -n M-H if-shell -F '#{m:*emacs*,#{pane_current_command}}' 'send-keys M-H' 'select-pane -L'
      bind -n M-L if-shell -F '#{m:*emacs*,#{pane_current_command}}' 'send-keys M-L' 'select-pane -R'
      bind -n M-K if-shell -F '#{m:*emacs*,#{pane_current_command}}' 'send-keys M-K' 'select-pane -U'
      bind -n M-J if-shell -F '#{m:*emacs*,#{pane_current_command}}' 'send-keys M-J' 'select-pane -D'
    '';
  };
}

{
  programs.emacs = {
    enable = true;
    init = {
      enable = true;
      recommendedGcSettings = true;
      startupTimer = true;
      postlude = ''
        ;; Key bindings
        (global-set-key [(ctrl l)] 'goto-line)
        (global-set-key [(ctrl c) (c)] 'comment-region)
        (global-set-key [(ctrl c) (u)] 'uncomment-region)
        (global-set-key [(ctrl c) (r)] 'replace-string)

        ;; Hide UI
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (menu-bar-mode -1)

        ;; Line/Column number mode
        (line-number-mode)
        (column-number-mode)

        ;; Parenthesis
        (setq show-paren-mode t)
        (setq show-paren-delay 0)

        ;; Yes/No
        (setq 'confirm-kill-emacs (quote y-or-n-p))
        (defalias 'yes-or-no-p 'y-or-n-p)

        ;; Startup
        (setq inhibit-startup-message t)
        (setq initial-scratch-message nil)

        ;; Disable backup files
        (setq make-backup-files nil)

        (setq-default show-trailing-whitespace t)
        (prefer-coding-system 'utf-8)
      '';
      usePackage = {
        bazel-mode = {
          enable = true;
          mode = [ ''"BUILD\\'"'' ];
          config = ''
            (setq bazel-mode-buildifier-before-save t)
          '';
        };
        dockerfile-mode = {
          enable = true;
          mode = [ ''"Dockerfile\\'"'' ];
        };
        go-mode = {
	        enable = true;
	        mode = [''"\\.go\\'"''];
          config = ''
            (setq gofmt-command "goimports")
            (add-hook 'before-save-hook 'gofmt-before-save)
          '';
	      };
        js = {
          enable = true;
          mode = [
            ''("\\.js\\'" . js-mode)''
            ''("\\.json\\'" . js-mode)''
          ];
          config = ''
            (setq js-indent-level 2)
          '';
        };
        json-mode = {
          enable = true;
          mode = [''"\\.json\\'"''];
        };
        markdown-mode = {
          enable = true;
          mode = [''"\\.md\\'"''];
        };
        nix-mode = {
          enable = true;
          mode = [''"\\.nix\\'"''];
        };
        protobuf-mode = {
          enable = true;
          mode = [
            ''"\\.proto\\'"''
            ''"\\.pb\\'"''
          ];
        };
        python = {
          enable = true;
          mode = [ ''("\\.py\\'" . python-mode)'' ];
        };
        rust-mode = {
          enable = true;
          mode = [''"\\.rs\\'"''];
        };
        systemd = {
          enable = true;
          defer = true;
        };
        uniquify = {
          enable = true;
        };
        web-mode = {
          enable = true;
          mode = [
            ''"\\.html\\'"''
            ''"\\.htm\\'"''
          ];
        };
        yaml-mode = {
          enable = true;
          mode = [''"\\.yaml\\'"''];
        };
      };
    };
  };
}


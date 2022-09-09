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
        (global-set-key [(ctrl c) (p)] 'projectile-command-map)

        ;; Tab width
        (setq tab-width 4)

        ;; Hide UI
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (menu-bar-mode -1)

        ;; Line/Column number mode
        (line-number-mode)
        (column-number-mode)

        ;; Parenthesis
        (show-paren-mode t)
        (setq show-paren-delay 0)

        ;; Yes/No
        (setq 'confirm-kill-emacs (quote y-or-n-p))
        (defalias 'yes-or-no-p 'y-or-n-p)

        ;; Startup
        (setq inhibit-startup-message t)
        (setq initial-scratch-message nil)

        ;; Disable backup files
        (setq make-backup-files nil)
        (setq auto-save-default nil)

        (setq-default show-trailing-whitespace t)
        (prefer-coding-system 'utf-8)

        ;; Autocomplete
        (ac-config-default)

        ;; aligns annotation to the right hand side
        (setq company-tooltip-align-annotations t)

        (load-theme 'zenburn t)
        (setq projectile-project-search-path '("~/dev/src/" "~/dev/go/src/github.com/giolekva/"))
        ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
      '';
      usePackage = {
        auto-complete = {
          enable = true;
        };
        # bazel-mode = {
        #   enable = true;
        #   mode = [ ''"BUILD\\'"'' ];
        #   config = ''
        #     (setq bazel-mode-buildifier-before-save t)
        #   '';
        # };
        company = {
          enable = true;
          config = ''
            (setq company-idle-delay 0)
            (setq company-minimum-prefix-length 1)
          '';
        };
        dockerfile-mode = {
          enable = true;
          mode = [ ''"Dockerfile\\'"'' ];
        };
        ediff = {
          enable = true;
          config = ''
            (setq ediff-split-window-function 'split-window-horizontally)
          '';
        };
        eglot = {
          enable = true;
        };
        eldoc = {
          enable = true;
        };
        # ggtags = {
        #   enable = true;
        # };
        go-mode = {
	        enable = true;
	        mode = [''"\\.go\\'"''];
          config = ''
            (add-hook 'go-mode-hook 'eglot-ensure)
            ;; (add-hook 'go-mode-hook #'lsp-deferred)

            (defun project-find-go-module (dir)
              (when-let ((root (locate-dominating-file dir "go.mod")))
                (cons 'go-module root)))

            (cl-defmethod project-root ((project (head go-module)))
              (cdr project))

            (add-hook 'project-find-functions #'project-find-go-module)


            (defun go-install-save-hooks ()
              (add-hook 'before-save-hook 'eglot-format-buffer t t)
              (add-hook 'before-save-hook 'eglot-code-action-organize-imports t t))
            (add-hook 'go-mode-hook 'go-install-save-hooks)

            (add-to-list 'eglot-server-programs '((go-mode) "gopls"))
            (add-hook 'go-mode-hook 'ivy-mode)
            (add-hook 'go-mode-hook 'company-mode)
          '';
        };
        ivy = {
          enable = true;
        };
        jest-test-mode = {
          enable = true;
          config = ''
            (add-hook 'typescript-mode-hook 'jest-test-mode)
            (add-hook 'js-mode-hook 'jest-test-mode)
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
        lsp-mode = {
          enable = true;
          config = ''
           (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
          '';
        };
        magit = {
          enable = true;
        };
        forge = {
          enable = true;
        };
        markdown-mode = {
          enable = true;
          mode = [''"\\.md\\'"''];
        };
        nix-mode = {
          enable = true;
          mode = [''"\\.nix\\'"''];
        };
        projectile = {
          enable = true;
          config = ''
            (setq projectile-completion-system 'ivy)
          '';
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
        rg = {
          enable = true;
        };
        ripgrep = {
          enable = true;
        };
        rjsx-mode = {
          enable = true;
          mode = [ ''("\\.tsx\\'" . rjsx-mode)'' ];
        };
        rust-mode = {
          enable = true;
          mode = [''"\\.rs\\'"''];
          config = ''
            (add-hook 'rust-mode-hook 'eglot-ensure)

            (defun project-find-rust-module (dir)
              (when-let ((root (locate-dominating-file dir "Cargo.toml")))
                (cons 'rust-module root)))

            (cl-defmethod project-root ((project (head rust-module)))
              (cdr project))

            (add-hook 'project-find-functions #'project-find-rust-module)

            (add-to-list 'eglot-server-programs '((rust-mode) "rust-analyzer"))
            (add-hook 'rust-mode-hook 'ivy-mode)
          '';
        };
        systemd = {
          enable = true;
          defer = true;
        };
        # tide = {
        #   enable = true;
        # };
        typescript-mode = {
          enable = true;
          mode = [
            ''("\\.ts\\'" . typescript-mode)''
            ''("\\.tsx\\'" . typescript-mode)''
          ];
          config = ''
            (setq typescript-indent-level 2)
            (setq-default indent-tabs-mode nil)

            (require 'ansi-color)
            (defun colorize-compilation-buffer ()
              (ansi-color-apply-on-region compilation-filter-start (point-max)))
            (add-hook 'compilation-filter-hook 'covlorize-compilation-buffer)

            (add-hook 'typescript-mode-hook 'eglot-ensure)
            ;; (add-hook 'typescript-mode-hook #'lsp-deferred)
            (add-hook 'typescript-mode-hook 'company-mode)

            (add-to-list 'eglot-server-programs '((typescript-mode) "typescript-language-server" "--stdio"))
          '';
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
        zenburn-theme = {
          enable = true;
        };
      };
    };
  };
}

            # ;; Tide
            # (defun setup-tide-mode ()
            #   ;; (interactive)
            #   (tide-setup)
            #   (flycheck-mode 1)
            #   (setq flycheck-check-syntax-automatically '(save mode-enabled))
            #   (eldoc-mode 1)
            #   (tide-hl-identifier-mode 1)
            #   (company-mode 1))


            # ;; formats the buffer before saving
            # ;; (add-hook 'before-save-hook 'tide-format-before-save)

            # (add-hook 'typescript-mode-hook #'setup-tide-mode)

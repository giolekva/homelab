{ config, pkgs, ... }:
{
  home.activation.createAuthinfo = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.authinfo" ]; then
      cat > "$HOME/.authinfo" << 'TMPL'
# Uncomment and fill in for magit-forge:
# machine api.github.com login YOUR_USERNAME^forge password ghp_YOUR_TOKEN
TMPL
    fi
  '';

  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = (pkgs.emacs-nox.override {
      withTreeSitter = true;
    });
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
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

        ;; macOS clipboard
        (setq interprogram-cut-function
              (lambda (text &rest _)
                (let ((process-connection-type nil))
                  (let ((proc (start-process "pbcopy" nil "pbcopy")))
                    (process-send-string proc text)
                    (process-send-eof proc)))))
        (setq interprogram-paste-function
              (lambda () (shell-command-to-string "pbpaste")))

        ;; Tab width
        (setq tab-width 4)

        ;; Hide UI
        (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
        (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
        (menu-bar-mode -1)

        ;; Line/Column number mode
        (line-number-mode)
        (column-number-mode)

        ;; Parenthesis
        (show-paren-mode t)
        (setq show-paren-delay 0)

        ;; Yes/No
        (setq confirm-kill-emacs nil)
        (defalias 'yes-or-no-p 'y-or-n-p)

        ;; Startup
        (setq inhibit-startup-message t)
        (setq initial-scratch-message nil)

        ;; Disable backup files
        (setq make-backup-files nil)
        (setq auto-save-default nil)

        (save-place-mode 1)

        (setq-default show-trailing-whitespace t)
        (add-hook 'eat-mode-hook (lambda () (setq show-trailing-whitespace nil)))
        (prefer-coding-system 'utf-8)

        ;; Autocomplete
        ;; (ac-config-default)

        ;; aligns annotation to the right hand side
        (setq company-tooltip-align-annotations t)

        (load-theme 'zenburn t)

        ;; Tree-sitter mode remapping
        (setq major-mode-remap-alist
              '((go-mode . go-ts-mode)
                (python-mode . python-ts-mode)
                (js-mode . js-ts-mode)
                (typescript-mode . typescript-ts-mode)
                (yaml-mode . yaml-ts-mode)
                (json-mode . json-ts-mode)))

        ;; Go eglot
        (defun project-find-go-module (dir)
          (when-let ((root (locate-dominating-file dir "go.mod")))
            (cons 'go-module root)))
        (cl-defmethod project-root ((project (head go-module)))
          (cdr project))
        (add-hook 'project-find-functions #'project-find-go-module)
        (defun go-install-save-hooks ()
          (add-hook 'before-save-hook 'eglot-format-buffer t t)
          (add-hook 'before-save-hook 'eglot-code-action-organize-imports t t))
        (add-hook 'go-ts-mode-hook 'eglot-ensure)
        (add-hook 'go-ts-mode-hook 'go-install-save-hooks)
        (add-hook 'go-ts-mode-hook 'ivy-mode)
        (add-to-list 'eglot-server-programs '((go-ts-mode go-mode) "gopls"))

        ;; TypeScript lsp-mode
        (setq typescript-indent-level 2)
        (setq-default indent-tabs-mode nil)
        (require 'ansi-color)
        (defun colorize-compilation-buffer ()
          (ansi-color-apply-on-region compilation-filter-start (point-max)))
        (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
        (add-hook 'typescript-ts-mode-hook 'lsp-deferred)
        (add-hook 'tsx-ts-mode-hook 'lsp-deferred)
        (add-hook 'js-ts-mode-hook 'lsp-deferred)

        ;; Disable auto-revert
        (global-auto-revert-mode -1)

        ;; Eglot
        (setq-default left-margin-width 1)
        (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
        (setq eglot-code-action-indicator "")

        ;; JS
        (setq js-indent-level 2)

        ;; Seamless emacs/tmux pane navigation (M-S-hjkl)
        (defun tmux-select-pane (direction)
          (call-process "tmux" nil nil nil "select-pane" (concat "-" direction)))

        (defun nav-left ()
          (interactive)
          (if (window-in-direction 'left) (windmove-left) (tmux-select-pane "L")))

        (defun nav-right ()
          (interactive)
          (if (window-in-direction 'right) (windmove-right) (tmux-select-pane "R")))

        (defun nav-up ()
          (interactive)
          (if (window-in-direction 'above) (windmove-up) (tmux-select-pane "U")))

        (defun nav-down ()
          (interactive)
          (if (window-in-direction 'below) (windmove-down) (tmux-select-pane "D")))

        (global-set-key (kbd "M-H") #'nav-left)
        (global-set-key (kbd "M-L") #'nav-right)
        (global-set-key (kbd "M-K") #'nav-up)
        (global-set-key (kbd "M-J") #'nav-down)
      '';
      usePackage = {
        vterm = {
          enable = true;
        };
        eat = {
          enable = true;
        };
        auto-complete = {
          enable = false;
        };
        company = {
          enable = true;
          config = ''
            (setq company-idle-delay 0.2)
            (setq company-minimum-prefix-length 2)
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
        go-mode = {
	        enable = true;
	        mode = [''"\\.go\\'"''];
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
        };
        json-mode = {
          enable = true;
          mode = [''"\\.json\\'"''];
        };
        lsp-mode = {
          enable = true;
          config = ''
            (setq lsp-idle-delay 0.500)
            (setq lsp-log-io nil)
            (setq lsp-completion-provider :capf)
            (setq lsp-completion-show-detail t)
            (setq lsp-completion-show-kind t)
            (setq lsp-response-timeout 30)
            (setq lsp-enable-file-watchers nil)
            (setq lsp-headerline-breadcrumb-enable nil)
            (setq lsp-lens-enable nil)
            (setq-default eldoc-documentation-functions nil)
            (setq lsp-disabled-clients '(ts-ls semgrep-ls))
            (lsp-register-client
             (make-lsp-client
              :new-connection (lsp-stdio-connection '("vtsls" "--stdio"))
              :major-modes '(typescript-mode typescript-ts-mode tsx-ts-mode js-mode js-ts-mode)
              :server-id 'vtsls))
            (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
          '';
        };
        lsp-ui = {
          enable = true;
          config = ''
            (setq lsp-ui-sideline-enable nil)
            (setq lsp-ui-doc-enable nil)
            (setq lsp-eldoc-render-all t)
            (setq lsp-ui-doc-show-with-cursor t)
          '';
        };
        which-key = {
          enable = true;
        };
        magit = {
          enable = true;
          config = ''
            (setq magit-git-executable "${pkgs.git}/bin/git")
          '';
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
          enable = false;
        };
        systemd = {
          enable = true;
          defer = true;
        };
        typescript-mode = {
          enable = true;
          mode = [
            ''("\\.ts\\'" . typescript-mode)''
            ''("\\.tsx\\'" . typescript-mode)''
          ];
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

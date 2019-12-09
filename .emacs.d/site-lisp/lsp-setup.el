(use-package lsp-mode
  :ensure t
  :hook ((prog-mode . lsp))
  :config (setq lsp-prefer-flymake nil)
  :commands lsp)

(use-package lsp-imenu
  :ensure lsp-mode
  :hook ((lsp-after-open . lsp-enable-imenu)))

(use-package lsp-ivy
 :ensure t
 :config
 (setq-default lsp-solargraph-log-level "debug")
 (setq-default lsp-keep-workspace-alive t)
 (add-hook 'after-init-hook 'global-company-mode)
 (define-key global-map (kbd "C-c C-c") 'company-complete))

(use-package company-lsp
  :ensure t
  :after company
  :after lsp-mode
  :config
  (push 'company-lsp company-backends)
  (company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  (setq company-show-numbers t))

;; lsp-ui: This contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses.
;; https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "C-c C-l .") 'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map (kbd "C-c C-l ?") 'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "C-c C-l r") 'lsp-rename)
  (define-key lsp-ui-mode-map (kbd "C-c C-l x") 'lsp-restart-workspace)
  (define-key lsp-ui-mode-map (kbd "C-c C-l w") 'lsp-ui-peek-find-workspace-symbol)
  (define-key lsp-ui-mode-map (kbd "C-c C-l i") 'lsp-ui-peek-find-implementation)
  (define-key lsp-ui-mode-map (kbd "C-c C-l d") 'lsp-describe-thing-at-point)
  (define-key lsp-ui-mode-map (kbd "C-c C-l e") 'lsp-execute-code-action)
  (setq lsp-ui-sideline-enable t
        lsp-ui-doc-enable t
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t))

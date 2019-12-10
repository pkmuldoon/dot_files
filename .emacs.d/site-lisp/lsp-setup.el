(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp)
  :init
  (setq lsp-auto-guess-root t        ; Detect project root
        lsp-prefer-flymake nil       ; Use lsp-ui and flycheck
        flymake-fringe-indicator-position 'right-fringe)
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

 
;; lsp-ui: This contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses.
;; https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))
  (setq lsp-ui-sideline-enable t
        lsp-ui-doc-enable t
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t)

  :bind (
         ("C-c C-l ." . lsp-ui-peek-find-definitions)
         ("C-c C-l ?" . lsp-ui-peek-find-references)
         ("C-c C-l r" . lsp-rename)
         ("C-c C-l x" . lsp-workspace-restart)
         ("C-c C-l w" . lsp-ui-peek-find-workspace-symbol)
         ("C-c C-l i" . lsp-ui-peek-find-implementation)
         ("C-c C-l d" . lsp-describe-thing-at-point)
         ("C-c C-l e" . lsp-execute-code-action)
        ))


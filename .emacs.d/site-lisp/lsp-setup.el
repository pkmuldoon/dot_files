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
  :demand
  :requires lsp-mode flycheck
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-flycheck-list-position 'right)
  (lsp-ui-flycheck-live-reporting t)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-peek-list-width 60)
  (lsp-ui-peek-peek-height 25)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions t)
  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))
  

  :bind (
         ("C-c u" . lsp-ui-imenu)
         ("C-c C-c ." . lsp-ui-peek-find-definitions)
         ("C-c C-c ?" . lsp-ui-peek-find-references)
         ("C-c C-c r" . lsp-rename)
         ("C-c C-c x" . lsp-workspace-restart)
         ("C-c C-c w" . lsp-ui-peek-find-workspace-symbol)
         ("C-c C-c i" . lsp-ui-peek-find-implementation)
         ("C-c C-c d" . lsp-describe-thing-at-point)
         ("C-c C-c e" . lsp-execute-code-action)
        ))


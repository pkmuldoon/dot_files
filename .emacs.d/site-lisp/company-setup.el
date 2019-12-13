;;; package --- Summary: Company mode setup"
;;; Commentary:
;;; Set up Company mode elements.
;;; Code:

(use-package company
  :ensure t
  :demand
  :diminish company-mode
  :config
  (setq company-idle-delay 0.3)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (push 'company-yasnippet company-backends)
  (yas-global-mode 1)
  (global-company-mode))
  

(use-package company-lsp
  :ensure t
  :after company
  :config
  (setq company-lsp-cache-candidates 'auto)
  (company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  (setq company-show-numbers t)
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t))

(provide 'company-setup)
;;; company-setup.el ends here

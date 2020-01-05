;;; package --- Summary: Company mode setup"
;;; Commentary:
;;; Set up Company mode elements.
;;; Code:

;; The problem with rails is there is so much baked-in magic that
;; auto-completion cannot find a lot of the things that are useful for
;; completion candidates. As a first strategy, use a language server to find the
;; symbol to complete on. However, this won't work for a lot of things in models
;; such as attributes: they are opaque to the language server. The model
;; attribute accessors are all mapped internally in rails to variables (that
;; aren't declared in the source so the language server won't seem them). All of
;; this preamble is to say, sometimes, especially in models, but also in
;; controllers and other helper-enabled facets of rails, fall back onto source
;; based, cruder, but more expansive completers when C-TAB is used.

(use-package company-try-hard
  :ensure t
  :commands (company-try-hard)
  :init
  (global-set-key (kbd "<C-tab>") #'company-try-hard)
  :bind (:map company-active-map
         ("C-<tab>" . company-try-hard)))

;; Pretty standard company completion framework setup. Should be no real surprises here.
(use-package company
  :ensure t
  :delight
  :custom
  (company-idle-delay 0.3)
  (company-show-numbers t)
  (company-tooltip-limit 15)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (company-tooltip-flip-when-above t)
  :config
  ;; tng, or tab-and-go, is my favourite front-end completer.
  (company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  (push 'company-yasnippet company-backends)
  (yas-global-mode 1)
  (global-company-mode))

(use-package company-quickhelp
   :ensure t
   :if window-system
   :init (company-quickhelp-mode 1))

(use-package robe
  :disabled
  :ensure t
  :bind ("C-M-." . robe-jump)
  :delight
  :hook (enh-ruby-mode . robe-mode)
  :init
  (with-eval-after-load 'company
    (push 'company-robe company-backends))
  :commands (robe-mode company-robe)
  :config
  (setq inf-ruby-console-environment "development")
  (robe-start 1)
  (setq confirm-kill-processes nil)
)

;; In Ruby's case this will be Solargraph which works well. In Ruby on Rails,
;; this will also be Solargraph which is not so good (it misses all the rails
;; generated magic method)
(use-package company-lsp
  :ensure t
  :after company
  :custom
   (company-lsp-async t)
   (company-lsp-cache-candidates 'auto)
   (company-lsp-enable-recompletion t)
   (company-lsp-filter-candidates t)
   (company-lsp-enable-snippet t)
  :config
  (push 'company-lsp company-backends))


(provide 'company-setup)
;;; company-setup.el ends here

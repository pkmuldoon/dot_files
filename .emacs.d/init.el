;; Set sane garbage collection during startup
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Profile startup.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


(require 'tls)
(push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles)

;; Package manager setup.
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Basic package defaults
(setq-default use-package-always-ensure t ; Auto-download package if not exists
              use-package-always-defer t ; Always defer load package to speed up startup
              use-package-verbose nil ; Don't report loading details
              use-package-expand-minimally t  ; make the expanded code as minimal as possible
              use-package-enable-imenu-support t) ; Let imenu find use-package definitions

;; Start a server if one is not running already
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))


;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (require 'use-package))

;; ** General startup configury for all modes.
;; Startup
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
;; Cursor preference
(setq-default cursor-type 'box)
(set-cursor-color "#ffffff") 
;; Always highlight current line
(setq hl-line-mode t)
;; No bells
(setq ring-bell-function 'ignore)
;; Other default stuff
;; Margin behaviour
(setq scroll-margin 5
      scroll-preserve-screen-position 1)
;; 80 char fill column
(setq-default fill-column 80)
;; Don’t warn me about opening large files
(setq large-file-warning-threshold nil)
;; Enable copy/past-ing from clipboard
(setq x-select-enable-clipboard t)
;; Fix weird color escape sequences
(setq system-uses-terminfo nil)
;; No yes or no
(defalias 'yes-or-no-p 'y-or-n-p)
;; Always reload the file if it changed on disk
;;(global-auto-revert-mode 1) 
;;(setq global-auto-revert-non-file-buffers t)
;;(setq auto-revert-verbose nil)
;; A nice line height
(setq-default line-spacing 1)
;; Highlight matching parens
(show-paren-mode 1)
;; SRGB support for OSX
(setq ns-use-srgb-colorspace t) 
;; Transparently open compressed files
(setq auto-compression-mode t)
;; Open splits horizontally
(setq split-height-threshold 0)
(setq split-width-threshold nil)
;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)
;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)
;; UTF-8
(setq locale-coding-system 'utf-8) 
(set-terminal-coding-system 'utf-8) 
(set-keyboard-coding-system 'utf-8) 
(set-selection-coding-system 'utf-8) 
(prefer-coding-system 'utf-8) 
;; Sentences do not need double spaces to end.
(set-default 'sentence-end-double-space nil)
;; Backups
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Define behaviour of home and end keys
;; Home = beginning of line or indent, End = end of lne
(defun my-smart-beginning-of-line ()
  "Move point to beginning-of-line. If repeat command it cycle
position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (and (eq last-command 'my-smart-beginning-of-line)
           (= (line-beginning-position) (point)))
      (back-to-indentation)
    (beginning-of-line)))
(global-set-key [home]     'my-smart-beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

;; MAC stuff
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Don't modify logs
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

; Global company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Historian
(use-package historian
  :ensure t)
(use-package ivy-historian
  :ensure t)

;; Ivy
(use-package ivy
  :ensure t
  :init
  (ivy-mode +1)
  (historian-mode +1)

  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-display-style 'fancy)

  :bind
   (("C-s" . swiper-isearch)
    ("C-x C-f" . counsel-find-file)
    ("C-x b" . ivy-switch-buffer))
   
  :config
  (ivy-historian-mode +1)
  ;; Allow recursive minibuffers. Escape quits ivy
  (setq enable-recursive-minibuffers t)
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit))

;; prog mode setup
(defun my-prog-mode-hook ()
  ;; Always show line numbers in prog-mode
  (global-display-line-numbers-mode)
  (setq linum-format "%4d")
  (setq column-number-mode t)
  (setq line-number-mode t)
  ;; Language tabs
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default c-basic-offset 2)
  (setq css-indent-offset 2)
  (setq js-indent-level 2)
  (setq ruby-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2))

(add-hook 'prog-mode-hook #'my-prog-mode-hook)
;; Frame titles
(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))


;; Keep cursor away from edges when scrolling up/down
(use-package smooth-scrolling
  :ensure t
  :init
  (smooth-scrolling-mode t))

;; chruby
(use-package chruby)

;;enh-ruby-mode
(use-package projectile
  :ensure t)
(use-package projectile-rails
  :ensure t)


(use-package enh-ruby-mode
  :ensure t
  :mode "\\.rb\\'"
  :mode "\\.erb\\'"
  :mode "\\ru\\'"
  :mode "Rakefile\\'"
  :mode "Gemfile\\'"
  :mode "Berksfile\\'"
  :mode "Vagrantfile\\'"
  :interpreter "ruby"

  :init
  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil)
  (add-hook 'enh-ruby-mode 'superword-mode)
  (projectile-rails-global-mode)
  (setq projectile-completion-system 'ivy)
  (add-hook 'enh-ruby-mode-hook 'yard-mode)
  (add-hook 'enh-ruby-mode-hook 'ruby-extra-highlight-mode)
  (chruby "ruby-2.6.5"))


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

(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode)
  :config
  ;; Ensure that flycheck prepends "bundle exec" to RuboCop invocations
  (with-eval-after-load 'enh-ruby-mode
    (defun spd-ruby-mode-defaults ()
      (setq-local flycheck-command-wrapper-function (lambda (command)
                                                      (if (string-suffix-p "/rubocop" (car command))
                                                          (append '("bundle" "exec") command)
                                                        command
                                                        )
                                                      ))
    )
    (setq spd-ruby-mode-hook 'spd-ruby-mode-defaults)

    (add-hook 'enh-ruby-mode-hook (lambda ()
                                    (run-hooks 'spd-ruby-mode-hook))))
)


(use-package flyspell
  :ensure t
  :config
  (setq flyspell-issue-message-flg nil)
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

;; Themes
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (set-frame-font "-*-Cascadia Code-normal-normal-normal-*-22-*-*-*-m-0-iso10646-1" nil t)
  (set-face-attribute 'default nil :height 200)
  (color-theme-sanityinc-tomorrow-night))

(use-package dumb-jump
  :ensure t
  :init
  (dumb-jump-mode +1)
  :custom
  (dumb-jump-selector 'ivy)
  :bind
     (("M-g j" . dumb-jump-go)
      ("M-g o" . dumb-jump-go-other-window)
      ("M-g b" . dumb-jump-back)
      ("M-g i" . dumb-jump-go-prompt)
      ;; Not related to dumb-jump but handy to have
      ("M-g s" . counsel-rg)
      ("M-g f" . counsel-fzf)))

;; keybindings interactive help
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
    which-key-side-window-max-width 0.33
    which-key-idle-delay 0.05)
  :diminish which-key-mode)

(provide 'init-which-key)

(use-package all-the-icons
  :ensure t)

(use-package spaceline
  :ensure t)

(use-package spaceline-all-the-icons
  :ensure t
  :after spaceline
  :config
  '(spaceline-all-the-icons-eyebrowse-display-name t)
  '(spaceline-all-the-icons-flycheck-alternate t)
  '(spaceline-all-the-icons-highlight-file-name t)
  '(spaceline-all-the-icons-window-number-always-visible t)
  (spaceline-all-the-icons-theme))

(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)

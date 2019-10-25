(setq gc-cons-threshold 2000000000)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(require 'tls)
(push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(tool-bar-mode -1)
(setq-default cursor-type 'box) 
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'ruby-mode)

(setq my-required-packages
      (list 'magit
	    'solarized-theme
	    'swiper ;; visual regex search
	    'exec-path-from-shell
	    'visual-regexp
	    'buffer-move ;; used for rotating buffersx
	    'visual-regexp-steroids
	    'ido-vertical-mode
	    'yafolding
	    's
	    'sourcemap
	    'bundler
	    'projectile
	    'projectile-rails
	    'scss-mode
	    'sass-mode
	    'f
	    'jump
	    'discover
	    'fiplr
	    'yard-mode ;; fontification in ruby comments
	    'goto-gem ;; Open dired in a gem directory
	    'ruby-tools
	    'ruby-additional
	    'ruby-hash-syntax
	    'ruby-refactor
	    'yasnippet
	    'yari
	    'ibuffer-vc
	    'rvm
	    'rinari
	    'web-mode
	    'feature-mode
	    'auto-compile
	    'yaml-mode
	    'rspec-mode
	    'inf-ruby
	    'smartscan ;; Quickly jumps between other symbols found at point in Emacs
	    'discover-my-major
	    'fullframe
	    'whole-line-or-region
	                ))

(dolist (package my-required-packages)
   (when (not (package-installed-p package))
     (package-refresh-contents)
     (package-install package)))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(setq-default mode-line-position
              '((-3 "%p") (size-indication-mode ("/" (-4 "%I")))
                " "
                (line-number-mode
                 ("%l" (column-number-mode ":%c")))))

(setq-default mode-line-format
              '("%e" mode-line-front-space
                ;; Standard info about the current buffer
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                mode-line-buffer-identification " " mode-line-position
                ;; Misc information, notably battery state and function name
                " "
                mode-line-misc-info
                ;; And the modes, which I don't really care for anyway
                " " mode-line-modes mode-line-end-spaces))

(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))

;; Format line numbers
(setq linum-format "%4d")

;; Turn on the left fringe
(set-fringe-mode '(10 . 0)) ;; 10px left, 0px right

;; Remove the fringe indicators
(when (boundp 'fringe-indicator-alist)
  (setq-default fringe-indicator-alist
                '(
                  (continuation . nil)
                  (overlay-arrow . nil)
                  (up . nil)
                  (down . nil)
                  (top . nil)
                  (bottom . nil)
                  (top-bottom . nil)
                  (empty-line . nil)
                  (unknown . nil))))


(setq scroll-margin 5
      scroll-preserve-screen-position 1)

(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))

(setq-default fill-column 80) ;; Sets a 80 character line width
(setq inhibit-startup-screen t) ;; Don’t display the default splash screen
(setq large-file-warning-threshold nil) ;; Don’t warn me about opening large files
(setq x-select-enable-clipboard t) ;; Enable copy/past-ing from clipboard
(setq system-uses-terminfo nil) ;; Fix weird color escape sequences
(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1) ;; Always reload the file if it changed on disk
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq-default line-spacing 1) ;; A nice line height
(show-paren-mode 1) ;; Highlight matching parens
(setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'control)
    (setq mac-option-modifier 'none)
(setq ns-use-srgb-colorspace t) ;; SRGB support for OSX
;; Transparently open compressed files
(setq auto-compression-mode t)
;; Open splits horizontally
(setq split-height-threshold 0)
(setq split-width-threshold nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Language tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq ruby-indent-level 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Keep cursor away from edges when scrolling up/down
(require 'smooth-scrolling)

;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

(use-package visual-regexp)
(use-package visual-regexp-steroids)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
 ;;if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
 ;;to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
(define-key global-map (kbd "C-c q") 'vr/query-replace)
 ;;if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
(use-package ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(define-key global-map (kbd "C-x f") 'helm-projectile)
(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
    (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
    (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
    map))
;;(global-set-key (kbd "s-d y") 'yafolding-discover)

(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))
(require 'chruby)
(chruby "ruby-2.6.3")

(projectile-rails-global-mode)
(add-hook 'ruby-mode-hook 'yard-mode)
(add-hook 'ruby-mode-hook 'ruby-extra-highlight-mode)

(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(smartscan-mode 1)
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
(set-face-attribute 'default nil :height 200)

(setq-default cursor-type '(block . 1))
(set-cursor-color "#ffffff") 
(use-package projectile-codesearch)

(use-package filecache)
(defun rails-add-proj-to-file-cache (dir)
  "Adds all the ruby and rhtml files recursively in the current directory to the file-cache"
  (interactive "DAdd directory: ")
    (file-cache-clear-cache)
    (file-cache-add-directory-recursively dir (regexp-opt (list ".rb" ".rhtml" ".xml" ".js" ".yml")))
    (file-cache-delete-file-regexp "\\.svn"))
(use-package company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
(company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))

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

 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (eterm-256color whole-line-or-region yasnippet yari yard-mode yaml-mode yafolding wrap-region which-key web-mode visual-regexp-steroids use-package sourcemap solarized-theme smooth-scrolling smartscan slim-mode simpleclip scss-mode sass-mode rvm ruby-tools ruby-refactor ruby-hash-syntax ruby-extra-highlight ruby-additional rspec-mode robe rinari restclient projectile-rails projectile-codesearch pallet neotree magit ledger-mode jsx-mode jade-mode ido-vertical-mode ibuffer-vc helm-swoop helm-projectile helm-descbinds helm-ag goto-gem goto-chg git-timemachine fullframe flymake-ruby flycheck fiplr feature-mode exec-path-from-shell discover-my-major discover counsel company-tabnine company-inf-ruby coffee-mode chruby change-inner bundler buffer-move auto-complete auto-compile anzu alchemist ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

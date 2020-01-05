;;; package --- Summary: General emacs settings"
;;; Commentary:
;;; An ancient set of defaults.
;;; Code:

;; ** General startup configuration acquired over twenty or so years of using
;; ** Emacs. I wish I'd documented why I changed these settings and I'll try to
;; ** remember as I document this configuration in 2019, but for half of them,
;; ** I'm not sure. However, if I turn that setting off, I immediately dislike
;; ** it but I'm not sure if it is because I've gotten used to it or originally
;; ** had a particular reason. So, reasons persist even if they are lost to
;; ** time!

;; Startup. Emacs should be ready and not noisy announcing itself. Also, turn
;; off most UI elements.

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(tool-bar-mode -1)

;; Cursor preference. I like blinking so don't disable that.
(setq-default cursor-type 'box)

;; Always highlight current line
(global-hl-line-mode t)

;; No bells
(setq ring-bell-function 'ignore)

;; Margin behaviour
(setq scroll-margin 5
      scroll-preserve-screen-position 1)

;; 80 char fill column
(setq-default fill-column 80)

;; Don’t warn me about opening large files
(setq large-file-warning-threshold nil)

;; The battle is long lost. Allow Ctrl-CVZ.
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(setq cua-keep-region-after-copy t) ;; Standard Linux/Windows behaviour

;; Enable copy/past-ing from clipboard
(setq x-select-enable-clipboard t)

;; Fix weird color escape sequences
(setq system-uses-terminfo nil)

;; No yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; A nice line height
(setq-default line-spacing 1)

;; Highlight matching parenthesis
(show-paren-mode t)

;; SRGB support for OSX
(setq ns-use-srgb-colorspace t) 

;; Transparently open compressed files
(setq auto-compression-mode t)

;; Open splits horizontally
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; Show active region
(transient-mark-mode t)
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

;; Put backup files neatly away                                                 
(let ((backup-dir "~/.emacs.d/backups/")
      (auto-saves-dir "~/.emacs.d/auto-saves/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-"))
  )

(setq backup-by-copying t    ; Don't delink hardlinks                           
      delete-old-versions t  ; Clean up the backups                             
      version-control t      ; Use version numbers on backups,                  
      kept-new-versions 5    ; keep some new versions                           
      kept-old-versions 2)   ; and some old ones, too

(setq create-lockfiles nil)

;; Define behaviour of [home] and [end] keys.
;;
;; [home] = beginning of line or the indent, and toggle between each.
;; [end] = end of line.

(defun my-smart-beginning-of-line ()
  "Move point to beginning-of-line. If repeated, cycle position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (and (eq last-command 'my-smart-beginning-of-line)
           (= (line-beginning-position) (point)))
      (back-to-indentation)
    (beginning-of-line)))
(global-set-key [home]        'my-smart-beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

;; Don't modify logs
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;; Frame titles
(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))
;; Delete selection mode
(delete-selection-mode t)

;; Auto kill current buffer (don't prompt)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Stop nagging about symlinks
(setq vc-follow-symlinks t)

;; Packages I use everywhere

;; Keep cursor away from edges when scrolling up/down

(use-package smooth-scrolling
  :ensure t
  :init
  (smooth-scrolling-mode t))

;; Keybindings interactive help. Super handy. An auto-dismissing window that
;; tells you the next sequence of key presses to do what. A map, in the dark
;; jungle, of Emacs keybindings.

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-right-bottom)
  :custom
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-side-window-max-width 0.33)
  (which-key-idle-delay 0.05)
  :delight)

;; Easier package upgrading and general manager. I use it for automatically
;; upgrading Emacs' packages.

(use-package paradox
  :ensure t
  :commands (paradox-list-packages)
  :config
  (paradox-enable)
  (paradox-menu-mode))

;; Quickie way to restart Emacs.

(use-package restart-emacs
  :ensure t
  :commands (restart-emacs))

;; Enable and setup windmove. Don't want to be nagged on error messages.
(eval-when-compile (require 'cl))
(defun ignore-error-wrapper (fn)
  "Function return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (lexical-let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))

(global-set-key [s-left] (ignore-error-wrapper 'windmove-left))
(global-set-key [s-right] (ignore-error-wrapper 'windmove-right))
(global-set-key [s-up] (ignore-error-wrapper 'windmove-up))
(global-set-key [s-down] (ignore-error-wrapper 'windmove-down))

(use-package undo-fu
  :init
  (global-unset-key (kbd "C-z"))
  :bind (("C-z" . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)))

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package direnv
  :ensure t
  :custom
  (direnv-always-show-summary t)
  (direnv-use-faces-in-summary t)
  :config
  (direnv-mode))

(provide 'emacs-general-defaults)
;;; emacs-general-defaults.el ends here

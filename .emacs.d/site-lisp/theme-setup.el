;; Themes
(setq custom-safe-themes t)
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (set-frame-font "Hack-22" nil t)
;;  (set-frame-font "-*-Cascadia Code-normal-normal-normal-*-22-*-*-*-m-0-iso10646-1" nil t)
  (set-face-attribute 'default nil :height 200)
  (color-theme-sanityinc-tomorrow-night))

(use-package all-the-icons
  :ensure t
  :commands (all-the-icons-icon-for-file all-the-icons-icon-for-buffer all-the-icons-icon-for-mode))

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode t))

(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init
  (beacon-mode +1))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p nil)
  ;;(setq spaceline-line-column-p nil)
  ;;(setq spaceline-line-p nil)
  (setq powerline-default-seperator 'curve)
  :init
  (spaceline-spacemacs-theme))

(use-package centaur-tabs
  :ensure t
  :demand

  :custom
  (centaur-tabs-style "box")
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'left)
  (centaur-tabs-modified-marker "*")
  (centaur-tabs-set-modified-marker t)

  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(use-package golden-ratio
  :ensure t
  :diminish (golden-ratio-mode)
  :init (golden-ratio-mode 1))

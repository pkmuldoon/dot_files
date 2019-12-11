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


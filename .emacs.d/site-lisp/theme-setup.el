;; Themes
(setq custom-safe-themes t)
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (set-frame-font "-*-Cascadia Code-normal-normal-normal-*-22-*-*-*-m-0-iso10646-1" nil t)
  (set-face-attribute 'default nil :height 200)
  (color-theme-sanityinc-tomorrow-night))

(use-package all-the-icons
  :ensure t)

(use-package spaceline
  :ensure t)

(use-package spaceline-all-the-icons
  :ensure t
  :after spaceline
  :init
  '(spaceline-all-the-icons-eyebrowse-display-name t)
  '(spaceline-all-the-icons-flycheck-alternate t)
  '(spaceline-all-the-icons-highlight-file-name t)
  '(spaceline-all-the-icons-window-number-always-visible t)
  (spaceline-all-the-icons-theme))

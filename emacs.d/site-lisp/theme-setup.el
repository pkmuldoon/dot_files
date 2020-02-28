;;; package --- Summary: themes
;;; Commentary:
;;; Set up theme elements.
;;; Code:

;; Don't nag about "in-theme" values being evaluated.
(setq custom-safe-themes t)

;; No particular reason for this theme other than I find it aesthetically
;; pleasing. I bounce between this theme and Zenburn.

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  ;; My current font choice: very clear and straightforward.
  ;; https://github.com/source-foundry/Hack
  ;;(set-frame-font "Hack-22" nil t)
  (set-frame-font "Hack-22" nil t)
  (set-face-attribute 'default nil :height 200)
  (color-theme-sanityinc-tomorrow-night))

;; I don't actually use this package currently but, when I end up removing it, I
;; end up putting it back. So just leave it here. `use-package` lazily loads
;; packages so it does no harm.

(use-package all-the-icons
  :ensure t
  :commands (all-the-icons-icon-for-file all-the-icons-icon-for-buffer all-the-icons-icon-for-mode))

;; Ditto above.

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

;; Subtly highlight actions when a change has been made within the configured
;; behaviour set. In my current theme, this is barely noticeable, but still useful in
;; highlighting things like "text that was undone" and other small, but useful,
;; highlights.

(use-package volatile-highlights
  :ensure t
  :delight
  :init
  (volatile-highlights-mode t))

;; Very useful package that displays a beacon on cursor location to draw
;; attention to it. I can imagine this being annoying to some, but I find it
;; super useful.

(use-package beacon
  :ensure t
  :delight
  :init
  (beacon-mode +1))

;; Modified, and pretty, modeline. I end up adding it and removing it on mood.
;; Currently, it is in favour.

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p nil)
  (setq powerline-default-seperator 'curve)
  :init
  (spaceline-spacemacs-theme))

;; A useful package which sizes subsequently opened windows to a 1.6 ratio. This
;; generally means pleasing window dimensions but it does occasionally do
;; something undesirable. These package only works with manually split windows
;; and does not appear to apply to  auto-opened windows.

(use-package golden-ratio
  :ensure t
  :delight
  :init (golden-ratio-mode 1))

(provide 'theme-setup)
;;; theme-setup.el ends here

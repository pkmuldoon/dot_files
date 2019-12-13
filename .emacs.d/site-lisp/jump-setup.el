;;; package --- Summary: dumb-jump setup"
;;; Commentary:
;;; Code:

(use-package dumb-jump
  :ensure t
  :after (ivy)
  :init
  (dumb-jump-mode +1)
  :custom
  (dumb-jump-selector 'ivy)
  :bind
  (
   ("M-g j" . dumb-jump-go)
   ("M-g o" . dumb-jump-go-other-window)
   ("M-g b" . dumb-jump-back)
   ("M-g i" . dumb-jump-go-prompt)
   ;; Not related contextually to dumb-jump but handy to have
   ("M-g s" . counsel-rg)
   ("M-g f" . counsel-fzf)
   ("M-g c" . counsel-codesearch)
  ))

(provide 'jump-setup)
;;; jump-setup.el ends here

;;; package --- Summary: dumb-jump setup"
;;; Commentary:
;;; Code:


;; We keep dump-jump as it is still pretty good at finding things without
;; invoking a language model. I also hijack this to add various other
;; code-search related functions

(use-package deadgrep
  :ensure t
  :bind ("M-g d" . deadgrep))

(use-package counsel-codesearch
  :ensure t)

(use-package dumb-jump
  :ensure t
  :after (ivy)
  :init
  (dumb-jump-mode +1)
  :custom
  (dumb-jump-selector 'ivy)
  (dumb-jump-prefer-searcher 'rg)
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

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

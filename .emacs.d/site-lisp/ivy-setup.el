;;; package --- Summary: ivy setup"
;;; Commentary:
;;; Code:

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :init
  (ivy-mode 1)
  (historian-mode 1)

  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-display-style 'fancy)

  :bind
  (("C-x b" . ivy-switch-buffer))
   
  :config
  (ivy-mode 1)
  (historian-mode 1)
  (ivy-historian-mode 1)

  ;; Allow recursive minibuffers. Escape quits ivy
  (setq enable-recursive-minibuffers t)
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit))

(use-package ivy-rich
  :ensure t
  :after (ivy)
  :init
  (setq ivy-rich-path-style 'abbrev
        ivy-virtual-abbreviate 'full)
  :config (ivy-rich-mode 1))

;; Historian
(use-package historian
  :ensure t
  :after (ivy))
(use-package ivy-historian
  :ensure t
  :after (ivy))

(use-package swiper
  :ensure t
  :after (ivy)
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(provide 'ivy-setup)
;;; ivy-setup.el ends here

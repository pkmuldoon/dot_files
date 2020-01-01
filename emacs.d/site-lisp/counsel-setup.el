;;; package --- Summary: Counsel mode setup"
;;; Commentary:
;;; Set up Company mode elements.
;;; Code:


(use-package counsel
  :ensure t
  :after (ivy)
  :config
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char)
         ("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c a" . counsel-ag)
         ("C-x l" . counsel-locate)
         (:map minibuffer-local-map ("C-r" . counsel-minibuffer-history))
        )
  )

(provide 'counsel-setup)
;;; counsel-setup.el ends here

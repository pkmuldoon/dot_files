

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(load-library "startup")
(load-library "package-setup")
(load-library "emacs-general-defaults")
(load-library "mac")
(load-library "ivy-setup")
(load-library "counsel-setup")
(load-library "programming-defaults")
(load-library "ruby-setup")
(load-library "lsp-setup")
(load-library "company-setup")
(load-library "flycheck-setup")
(load-library "flyspell-setup")
(load-library "jump-setup")
(load-library "theme-setup")

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

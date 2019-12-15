;;; package --- Summary: Bootstrap
;;; Commentary:
;;; Code:

(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(require 'startup)
(require 'package-setup)
(require 'theme-setup)
(require 'emacs-general-defaults)
(require 'mac)
(require 'ivy-setup)
(require 'programming-defaults)
(require 'ruby-setup)
(require 'js2-setup)
(require 'company-setup)
(require 'lsp-setup)
(require 'flycheck-setup)
(require 'flyspell-setup)
(require 'counsel-setup)
(require 'jump-setup)


(provide 'init)
;;; init.el ends here

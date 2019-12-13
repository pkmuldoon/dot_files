;;; package --- Summary: Packages setup"
;;; Commentary:
;;; Code:

;; Package manager setup.
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Basic package defaults
(setq-default use-package-always-ensure t ; Auto-download package if not exists
              use-package-always-defer t ; Always defer load package to speed up startup
              use-package-verbose nil ; Don't report loading details
              use-package-expand-minimally t  ; make the expanded code as minimal as possible
              use-package-enable-imenu-support t) ; Let imenu find use-package definitions

(use-package use-package-ensure-system-package
  :ensure t)

(provide 'package-setup)
;;; package-setup.el ends here

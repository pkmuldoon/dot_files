;;; package --- Summary: Mac OS setup"
;;; Commentary:
;;; Code:

;; If emacs is started from a desktop, find out the shell environment values by
;; opening and interrogating a shell.
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta nil
      mac-command-modifier 'control
      mac-option-modifier 'none)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(provide 'mac)
;;; mac.el ends here

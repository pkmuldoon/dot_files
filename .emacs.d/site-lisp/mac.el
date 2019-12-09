(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

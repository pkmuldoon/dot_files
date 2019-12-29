;;; package --- summary
;;; Commentary:
;;; Code:

;; Note iterm2 shell integrations tend to pollute the shell so make sure, in
;; our setup, if we are running iterm2 that the following files are not
;; being loaded:
;;   .iterm2_shell_integration.bash
;;   .iterm2_shell_integration.zsh
;; 

(defun my-shell-mode-variable ()
  "Set a font in a shell that supports Powerline glyphs."
(interactive)
  (setq buffer-face-mode-face '(:family "Source Code Pro for Powerline" :height 500 :width normal))
  (buffer-face-mode))

(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))

(add-hook 'term-exec-hook 'my-term-use-utf8)
(add-hook 'term-mode-hook #'eterm-256color-mode) 

(add-hook 'shell-mode-hook #'my-shell-mode-variable)
(add-hook 'shell-mode-hook #'company-mode)

(define-key shell-mode-map (kbd "TAB") #'company-manual-begin))

(provide 'shell-setup)
;;; shell-setup.el ends here

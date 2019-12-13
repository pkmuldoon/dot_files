;;; package --- summary
;;; Commentary:
;;; Code:
(defun my-shell-mode-variable ()
  "Set a font in a shell that supports Powerline glyphs."
(interactive)
  (setq buffer-face-mode-face '(:family "Source Code Pro for Powerline" :height 100 :width normal))
   (buffer-face-mode))

(add-hook 'term-mode-hook #'eterm-256color-mode) 
(add-hook 'shell-mode-hook #'my-shell-mode-variable)
(add-hook 'shell-mode-hook #'company-mode)
(define-key shell-mode-map (kbd "TAB") #'company-manual-begin))

(provide 'shell-setup)
;;; shell-setup.el ends here

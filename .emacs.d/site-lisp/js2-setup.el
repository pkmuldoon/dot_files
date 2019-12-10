(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :init
  (setq-default js2-concat-multiline-strings 'eol)
  (setq-default js2-global-externs '("module" "require" "setTimeout" "clearTimeout" "setInterval"
                                     "clearInterval" "location" "__dirname" "console" "JSON" "window"
                                     "process" "fetch"))
  (setq-default js2-strict-trailing-comma-warning t)
  (setq-default js2-strict-inconsistent-return-warning nil)
  :bind (:map js2-mode-map
              ("M-r"        . node-js-eval-region-or-buffer)
              ("M-R"        . refresh-chrome)
              ("M-s-<up>"   . js2r-move-line-up)
              ("M-s-<down>" . js2r-move-line-down)
              ("C-<left>"   . js2r-forward-barf)
              ("C-<right>"  . js2r-forward-slurp)
              ("M-m S"      . js2r-split-string))
  :config
  (use-package prettier-js :ensure t)
  (use-package rjsx-mode :ensure t
    :mode "\\.jsx\\'"
    :magic ("import React" . rjsx-mode))
  (use-package js2-refactor :ensure t)
  (use-package json-mode :ensure t)
  (use-package nodejs-repl :ensure t)
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (add-hook 'js2-mode-hook
            '(lambda ()
               (js2-refactor-mode)
               (js2r-add-keybindings-with-prefix "M-m")
               (key-chord-define js2-mode-map ";;" (λ (save-excursion (move-end-of-line nil) (insert ";"))))
               (key-chord-define js2-mode-map ",," (λ (save-excursion (move-end-of-line nil) (insert ","))))

               (define-key js2-mode-map (kbd ";")
                 (λ (if (looking-at ";")
                        (forward-char)
                      (funcall 'self-insert-command 1))))

               ;; Overwrite this function to output to minibuffer
               (defun nodejs-repl-execute (command &optional buf)
                 "Execute a command and output the result to minibuffer."
                 (let ((ret (nodejs-repl--send-string (concat command "\n"))))
                   (setq ret (replace-regexp-in-string nodejs-repl-ansi-color-sequence-re "" ret))
                   ;; delete inputs
                   (setq ret (replace-regexp-in-string "\\(\\w\\|\\W\\)+\r\r\n" "" ret))
                   (setq ret (replace-regexp-in-string "\r" "" ret))
                   (setq ret (replace-regexp-in-string "\n.*\\'" "" ret))
                   (setq ret (replace-regexp-in-string "\nundefined\\'" "" ret))
                   (message ret)))

               (defadvice nodejs-repl (after switch-back activate)
                 (delete-window)))))


(provide 'setup-js2-mode)

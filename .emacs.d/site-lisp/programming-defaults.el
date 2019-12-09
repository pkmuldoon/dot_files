;; prog mode setup
(defun my-prog-mode-hook ()
  ;; Always show line numbers in prog-mode
  (global-display-line-numbers-mode)
  (setq linum-format "%4d")
  (setq column-number-mode t)
  (setq line-number-mode t)
  ;; Language tabs
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (setq-default c-basic-offset 2)
  (setq css-indent-offset 2)
  (setq js-indent-level 2)
  (setq ruby-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2))

(add-hook 'prog-mode-hook #'my-prog-mode-hook)

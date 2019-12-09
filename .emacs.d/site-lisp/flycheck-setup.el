(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode)
  :config
  ;; Ensure that flycheck prepends "bundle exec" to RuboCop invocations
  (with-eval-after-load 'enh-ruby-mode
    (defun spd-ruby-mode-defaults ()
      (setq-local flycheck-command-wrapper-function (lambda (command)
                                                      (if (string-suffix-p "/rubocop" (car command))
                                                          (append '("bundle" "exec") command)
                                                        command
                                                        )
                                                      ))
    )
    (setq spd-ruby-mode-hook 'spd-ruby-mode-defaults)

    (add-hook 'enh-ruby-mode-hook (lambda ()
                                    (run-hooks 'spd-ruby-mode-hook))))
)

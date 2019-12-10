(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode)
  :init
  
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8)
  (global-flycheck-mode)
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

(use-package flycheck-pos-tip
  :ensure t
  :after flyheck
  :init
    (flycheck-pos-tip-mode 1))

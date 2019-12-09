;; Set sane garbage collection during startup
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Profile startup.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                              gcs-done)))


;; Start a server if one is not running already
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

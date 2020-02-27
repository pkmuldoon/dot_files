;;; package --- Summary: Startup setup"
;;; Commentary:
;;; Set up startup elements.
;;; Code:

;; Set sane garbage collection defaults during startup. Strictly speaking, with
;; `use-package` and lazy-loading, we don't really need to do garbage collection
;; cat-herding at startup. Leave it here anyway as it does no harm.

(setq gc-cons-threshold  most-positive-fixnum)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Profile startup. See above for being sensitive to startup time and just
;; leaving it here as it does no harm.

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                              gcs-done)))


;; Start an Emacs server if one is not already running.
;; Set window size early.

(setq initial-frame-alist '((top . 0) (left . 0)
                            (fullscreen . fullheight)
                            (font . "Hack-22")
                            ))

(setq default-frame-alist '((top . 0) (left . 0)
                            (fullscreen . fullheight)
                            (font . "Hack-22")
                            ))

(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(provide 'startup)
;;; startup.el ends here

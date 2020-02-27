;;; package --- Summary: Ruby mode and packages setup"
;;; Commentary:
;;; Code:

;; chruby
(use-package chruby
  :ensure t
  :commands (chruby chruby-use chruby-use-corresponding))

(use-package projectile
  :ensure t)

(use-package projectile-rails
  :ensure t
  :delight)

;; I prefer enh-ruby-mode over ruby-mode as the enhanced version uses Ruby's own
;; ripper system for syntax highlighting.

(use-package enh-ruby-mode
  :ensure t
  :mode "\\.rb\\'"
  :mode "\\.erb\\'"
  :mode "\\ru\\'"
  :mode "Rakefile\\'"
  :mode "Gemfile\\'"
  :mode "Berksfile\\'"
  :mode "Vagrantfile\\'"
  :interpreter "ruby"

  :init
  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil)
  (projectile-rails-global-mode)
  (superword-mode 1)
  (setq projectile-completion-system 'ivy)
  (chruby "ruby-2.6.5")
  (setq ruby-use-smie t)
  )

(use-package ruby-extra-highlight
  :ensure t
  :delight
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-extra-highlight-mode))

(use-package yard-mode
  :ensure t
  :delight
  :after enh-ruby-mode)

(use-package ruby-tools
  :ensure t
  :delight
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-tools-mode))

(use-package ruby-electric
  :ensure t
  :delight
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-electric-mode))

(use-package rspec-mode
  :ensure t
  :after enh-ruby-mode
  :hook (enh-ruby-mode . rspec-mode))

(use-package goto-gem
  :ensure t
  :after enh-ruby-mode
  :commands (goto-gem))

(use-package bundler
  :ensure t
  :after enh-ruby-mode
  :commands (bundle-open bundle-console bundle-install bundle-update bundle-check))

(use-package scss-mode
  :ensure t
  :mode "\\.scss\\'")

(use-package inf-ruby
  :ensure t
  :after enh-ruby-mode
  :commands inf-ruby-minor-mode
  :hook (
         (enh-ruby-mode . inf-ruby-minor-mode)
         (compilation-filter . inf-ruby-auto-enter)
         (after-init . inf-ruby-auto-enter)
        ))

(provide 'ruby-setup)
;;; ruby-setup.el ends here


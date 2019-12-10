;; chruby
(use-package chruby
  :ensure t
  :commands (chruby chruby-use chruby-use-corresponding))

;;enh-ruby-mode
(use-package projectile
  :ensure t)
(use-package projectile-rails
  :ensure t)

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
  (chruby "ruby-2.6.5"))

(use-package ruby-extra-highlight
  :ensure t
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-extra-highlight-mode))

(use-package yard-mode
  :ensure t
  :after enh-ruby-mode
  :hook (enh-ruby-mode . yard-mode))

(use-package ruby-tools
  :ensure t
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-tools-mode))

(use-package ruby-electric
  :ensure t
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
  :hook (enh-ruby-mode . inf-ruby-minor-mode))

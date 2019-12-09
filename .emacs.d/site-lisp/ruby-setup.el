;; chruby
(use-package chruby)

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
  (add-hook 'enh-ruby-mode 'superword-mode)
  (projectile-rails-global-mode)
  (setq projectile-completion-system 'ivy)
  (add-hook 'enh-ruby-mode-hook 'yard-mode)
  (add-hook 'enh-ruby-mode-hook 'ruby-extra-highlight-mode)
  (chruby "ruby-2.6.5"))

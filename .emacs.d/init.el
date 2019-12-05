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


(require 'tls)
(push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles)

;; pallet and cask package management.
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

; package manager init for archives.
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("smelpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; Basic package defaults
(setq-default use-package-always-ensure t ; Auto-download package if not exists
              use-package-always-defer t ; Always defer load package to speed up startup
              use-package-verbose nil ; Don't report loading details
              use-package-expand-minimally t  ; make the expanded code as minimal as possible
              use-package-enable-imenu-support t) ; Let imenu finds use-package definitions

(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

;; General startup configury
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq tool-bar-mode nil)
(setq-default cursor-type 'box)
(setq hl-line-mode t)
(setq inhibit-splash-screen t)
(setq ring-bell-function 'ignore)
(setq initial-major-mode 'enh-ruby-mode)

(setq my-required-packages
      (list 
	    'swiper 
	    'exec-path-from-shell
	    'buffer-move ;; used for rotating buffersx
	    's
	    'sourcemap
	    'bundler
	    'projectile
	    'projectile-rails
	    'scss-mode
	    'sass-mode
	    'f
	    'jump
	    'discover
	    'fiplr
	    'yard-mode ;; fontification in ruby comments
	    'goto-gem ;; Open dired in a gem directory
	    'ruby-tools
	    'ruby-additional
	    'ruby-hash-syntax
	    'ruby-refactor
	    'yasnippet
	    'yari
	    'ibuffer-vc
	    'rvm
	    'web-mode
	    'feature-mode
	    'auto-compile
	    'yaml-mode
	    'rspec-mode
	    'inf-ruby
	    'smartscan ;; Quickly jumps between other symbols found at point in Emacs
	    'discover-my-major
	    'fullframe
	    'whole-line-or-region
	                ))

(dolist (package my-required-packages)
   (when (not (package-installed-p package))
     (package-refresh-contents)
     (package-install package)))

;; mac stuff
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))
(setq mac-option-key-is-meta t)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'control)
    (setq mac-option-modifier 'none)

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

; ivy/company
(add-hook 'after-init-hook 'global-company-mode)
(setq ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

;; historian
(use-package historian)
(use-package ivy-historian)

(use-package ivy
  :init
  (ivy-mode +1)
  (historian-mode +1)

  :config
  (ivy-historian-mode +1))

;; Always show line numbers
(global-display-line-numbers-mode)
(setq linum-format "%4d")
(setq column-number-mode t)
(setq line-number-mode t)
      
;; Mode line setup
(setq-default mode-line-position
              '((-3 "%p") (size-indication-mode ("/" (-4 "%I")))
                " "
                (line-number-mode
                 ("%l" (column-number-mode ":%c")))))

(setq-default mode-line-format
              '("%e" mode-line-front-space
                ;; Standard info about the current buffer
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                mode-line-buffer-identification " " mode-line-position
                ;; Misc information, notably battery state and function name
                " "
                mode-line-misc-info
                ;; And the modes, which I don't really care for anyway
                " " mode-line-modes mode-line-end-spaces))

;; Frame titles
(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))

;; Fringes
;; Turn on the left fringe
(set-fringe-mode '(10 . 0)) ;; 10px left, 0px right

;; Remove the fringe indicators
(when (boundp 'fringe-indicator-alist)
  (setq-default fringe-indicator-alist
                '(
                  (continuation . nil)
                  (overlay-arrow . nil)
                  (up . nil)
                  (down . nil)
                  (top . nil)
                  (bottom . nil)
                  (top-bottom . nil)
                  (empty-line . nil)
                  (unknown . nil))))


; Other default stuff
(setq scroll-margin 5
      scroll-preserve-screen-position 1)
(setq-default fill-column 80) ;; Sets a 80 character line width
(setq large-file-warning-threshold nil) ;; Don’t warn me about opening large files
(setq x-select-enable-clipboard t) ;; Enable copy/past-ing from clipboard
(setq system-uses-terminfo nil) ;; Fix weird color escape sequences
(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1) ;; Always reload the file if it changed on disk
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq-default line-spacing 1) ;; A nice line height
(show-paren-mode 1) ;; Highlight matching parens
(setq ns-use-srgb-colorspace t) ;; SRGB support for OSX
;; Transparently open compressed files
(setq auto-compression-mode t)
;; Open splits horizontally
(setq split-height-threshold 0)
(setq split-width-threshold nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Language tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq ruby-indent-level 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Keep cursor away from edges when scrolling up/down
(require 'smooth-scrolling)

;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)
(define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)


;; Sentences do not need double spaces to end.
(set-default 'sentence-end-double-space nil)

;; chruby
(require 'chruby)
(chruby "ruby-2.6.5")

;; Enhanced Ruby
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; Projectile
(projectile-rails-global-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-hook 'enh-ruby-mode-hook 'ruby-extra-highlight-mode)

;; LSP completion
(require 'company-lsp)
(require 'lsp-ui)
(require 'lsp-ui-imenu)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'enh-ruby-mode-hook 'flycheck-mode)

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
(define-key lsp-ui-mode-map (kbd "C-c C-l .") 'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map (kbd "C-c C-l ?") 'lsp-ui-peek-find-references)
(define-key lsp-ui-mode-map (kbd "C-c C-l r") 'lsp-rename)
(define-key lsp-ui-mode-map (kbd "C-c C-l x") 'lsp-restart-workspace)
(define-key lsp-ui-mode-map (kbd "C-c C-l w") 'lsp-ui-peek-find-workspace-symbol)
(define-key lsp-ui-mode-map (kbd "C-c C-l i") 'lsp-ui-peek-find-implementation)
(define-key lsp-ui-mode-map (kbd "C-c C-l d") 'lsp-describe-thing-at-point)
(define-key lsp-ui-mode-map (kbd "C-c C-l e") 'lsp-execute-code-action)

(setq lsp-ui-sideline-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-peek-enable t)
(setq lsp-ui-peek-always-show t)

(require 'lsp-ivy)
(setq-default lsp-solargraph-log-level "debug")
(setq-default lsp-keep-workspace-alive t)
(add-hook 'prog-mode-hook #'lsp)
(add-hook 'after-init-hook 'global-company-mode)
(define-key global-map (kbd "C-c C-c") 'company-complete)
'(company-scrollbar-bg ((t (:background "#323445"))))
'(company-scrollbar-fg ((t (:background "#393939"))))
'(company-tooltip ((t (:inherit default :background "#21222d"))))
'(company-tooltip-common ((t (:inherit font-lock-constant-face))))
'(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))

;; Flymake
(smartscan-mode 1)
(require 'flymake-ruby)
(add-hook 'enh-ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)
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

;; FlySpell
(require 'flyspell)
(setq flyspell-issue-message-flg nil)
(add-hook 'enh-ruby-mode-hook
          (lambda () (flyspell-prog-mode)))
(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'sanityinc-tomorrow-night t)
(set-frame-font "-*-Cascadia Code-normal-normal-normal-*-22-*-*-*-m-0-iso10646-1" nil t)
(set-face-attribute 'default nil :height 200)
(setq-default cursor-type '(block . 1))
(set-cursor-color "#ffffff") 

(company-tng-configure-default)
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

;; Home = beginning of line, End = end of lne
(defun my-smart-beginning-of-line ()
  "Move point to beginning-of-line. If repeat command it cycle
position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (and (eq last-command 'my-smart-beginning-of-line)
           (= (line-beginning-position) (point)))
      (back-to-indentation)
    (beginning-of-line)))

(global-set-key [home]     'my-smart-beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)


;; dumb jump
(setq dumb-jump-selector 'ivy)
(define-key global-map (kbd "M-g j") 'dumb-jump-go)
(define-key global-map (kbd "M-g o") 'dumb-jump-go-other-window)
(define-key global-map (kbd "M-g b") 'dumb-jump-back)
(define-key global-map (kbd "M-g i") 'dumb-jump-go-prompt)
(define-key global-map (kbd "M-g s") 'counsel-rg)
(define-key global-map (kbd "M-g f") 'fzf)
(define-key global-map (kbd "C-x C-g") 'fzf)

;; keybindings interactive help
(use-package which-key
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
    which-key-side-window-max-width 0.33
    which-key-idle-delay 0.05)
  :diminish which-key-mode)

(provide 'init-which-key)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "73abbe794b6467bbf6a9f04867da0befa604a072b38012039e8c1ba730e5f7a5" "a4f8d45297894ffdd98738551505a336a7b3096605b467da83fae00f53b13f01" "6bf841f77d5eb01455d82ae436e3e25277daaef4ee855a3572589dad1b3ac4b3" "56ed144b399e3fbf1fcfc5af854f0053b21c0e3e7cfc824f0473da6f4e179695" "4aafea32abe07a9658d20aadcae066e9c7a53f8e3dfbd18d8fa0b26c24f9082c" "4c028a90479b9ad4cbb26ae7dc306dded07718749fe7e4159621a8aebac40213" "fa2af0c40576f3bde32290d7f4e7aa865eb6bf7ebe31eb9e37c32aa6f4ae8d10" default)))
 '(package-selected-packages
   (quote
    (yasnippet-snippets lsp-ivy lsp-ui company-lsp counsel-projectile fzf ivy-historian ivy-rich which-key-posframe dumb-jump enh-ruby-mode flyspell-correct-ivy color-theme-sanityinc-tomorrow leuven-theme async bind-key cask company dash f git-commit helm helm-core inf-ruby ivy package-build projectile swiper transient with-editor counsel-codesearch abc-mode all-the-icons-ivy eterm-256color whole-line-or-region yasnippet yari yard-mode yaml-mode yafolding wrap-region which-key web-mode visual-regexp-steroids use-package sourcemap solarized-theme smooth-scrolling smartscan slim-mode simpleclip scss-mode sass-mode rvm ruby-tools ruby-refactor ruby-hash-syntax ruby-extra-highlight ruby-additional rspec-mode robe rinari restclient projectile-rails projectile-codesearch pallet neotree magit ledger-mode jsx-mode jade-mode ido-vertical-mode ibuffer-vc helm-swoop helm-projectile helm-descbinds helm-ag goto-gem goto-chg git-timemachine fullframe flymake-ruby flycheck fiplr feature-mode exec-path-from-shell discover-my-major discover counsel company-tabnine company-inf-ruby coffee-mode chruby change-inner bundler buffer-move auto-complete auto-compile anzu alchemist ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

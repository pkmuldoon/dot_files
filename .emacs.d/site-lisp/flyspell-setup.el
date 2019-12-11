(use-package flyspell
  :ensure t
  :diminish flyspell-mode
  :hook ((prog-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode))
  :custom
  (flyspell-issue-message-flg nil)

  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-dictionary "en_GB"
        ispell-silently-savep t
        ispell-personal-dictionary "~/.emacs.d/.aspell.en.pws"
        ispell-extra-args '("--sug-mode=ultra")))


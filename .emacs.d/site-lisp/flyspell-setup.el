(use-package flyspell
  :ensure t
  :diminish flyspell-mode
  :hook ((prog-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode))
  :config
  (setq flyspell-issue-message-flg nil)
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra")))


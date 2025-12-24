;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
    '((kdl-ts-mode :url "https://github.com/merrickluo/kdl-ts-mode")
       (kbd-mode :url "https://github.com/kmonad/kbd-mode")
       (auto-tangle-mode :url
         "https://github.com/progfolio/auto-tangle-mode.el")
       (combobulate :url "https://github.com/mickeynp/combobulate")))
 '(safe-local-variable-values
    '((checkdoc-package-keywords-flag)
       (eval add-hook 'after-save-hook #'org-gfm-export-to-markdown t t)
       (jinx-dir-local-words . "configurated")
       (org-refile-targets (nil :maxlevel . 6))
       (eval load-file "./ceamx-dev-loader.el")
       (org-archive-location . "graveyard/%s.archive::datetree/")
       (apheleia-formatter . alejandra) (just-indent-offset . 2)
       (apheleia-formatter . nixfmt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

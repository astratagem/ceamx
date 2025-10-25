;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(activities aggressive-indent auto-tangle-mode bookmark-in-project
                breadcrumb cape combobulate consult-eglot
                consult-notmuch corfu crux cursory cycle-quotes
                denote-journal denote-silo devdocs diff-hl dired-preview
                dired-subtree diredfl doct doric-themes dotenv-mode
                drag-stuff dumb-jump easy-kill eat edit-indirect
                ef-themes elfeed-goodies elfeed-org elfeed-score
                elfeed-tube-mpv elisp-demos embark-consult emmet-mode
                envrc eros exec-path-from-shell expreg fish-mode
                flycheck-eglot flycheck-phpstan fontaine free-keys
                git-modes git-timemachine gnu-elpa-keyring-update
                golden-ratio gptel help-find helpful hl-todo htmlize
                ialign indent-bars jinx jq-mode just-mode just-ts-mode
                kbd-mode kdl-ts-mode keycast keymap-utils kind-icon
                languagetool ligature lin lispy macrostep magit
                marginalia mastodon minions mlscroll modus-themes
                morlock mugur mwim neon-mode nerd-icons-completion
                nerd-icons-dired nix-ts-mode no-littering
                notmuch-indicator olivetti orderless org-appear
                org-download org-modern org-node org-remark org-sidebar
                org-web-tools outli ox-gfm page-break-lines pandoc-mode
                pdf-tools popper pulsar puni rainbow-mode reformatter
                rustic savefold setup shift-number show-font
                smart-newline spacious-padding spdx standard-themes
                string-inflection substitute systemd tempel tmr
                transpose-frame treesit-auto treesit-fold typo
                typst-preview typst-ts-mode undo-fu-session uuidgen
                vc-jj verb vertico vundo web-mode websocket wgrep
                yaml-pro yasnippet yuck-mode))
 '(package-vc-selected-packages
   '((typst-preview :url "https://github.com/havarddj/typst-preview.el")
     (kdl-ts-mode :url "https://github.com/merrickluo/kdl-ts-mode")
     (kbd-mode :url "https://github.com/kmonad/kbd-mode")
     (auto-tangle-mode :url
                       "https://github.com/progfolio/auto-tangle-mode.el")
     (combobulate :url "https://github.com/mickeynp/combobulate")))
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook #'org-gfm-export-to-markdown t t)
     (jq-indent-offset . 2) (just-indent-offset . 2)
     (typst-ts-indent-offset . 2) (just-indent-offset . 4)
     (just-ts-indent-offset . 4) (just-ts-indent-offset . 2)
     (apheleia-formatter . nixfmt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

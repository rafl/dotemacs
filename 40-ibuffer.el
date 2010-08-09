(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("perl" (mode . cperl-mode))
               ("docs" (mode . pod-mode))
               ("config" (name . "\\.conf$"))
               ("gnus" (or
                        (mode . message-mode)
                        (mode . bbdb-mode)
                        (mode . mail-mode)
                        (mode . gnus-group-mode)
                        (mode . gnus-summary-mode)
                        (mode . gnus-article-mode)
                        (name . "^\\.bbdb$")
                        (name . "^\\.newsrc-dribble")))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (mode . emacs-lisp-mode)))
               ("dired" (mode . dired-mode))
               ("erc" (mode . erc-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

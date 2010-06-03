(setq auto-mode-alist
      (cons '("TODO$" . org-mode)
            (cons '("todo$" . org-mode)
                  auto-mode-alist)))

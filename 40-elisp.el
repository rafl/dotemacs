(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook (lambda () (eldoc-mode))))

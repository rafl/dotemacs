(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook eshell-mode-hook))
  (add-hook hook (lambda () (eldoc-mode))))

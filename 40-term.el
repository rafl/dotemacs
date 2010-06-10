(require 'term)
(add-hook 'term-mode-hook
          (lambda () (setq show-trailing-whitespace nil)))

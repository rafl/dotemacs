(require 'git-commit-mode)
(add-hook 'git-commit-commit-hook
          (lambda () (save-buffers-kill-terminal)))

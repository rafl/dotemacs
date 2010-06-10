(require 'git-commit)
(add-hook 'git-commit-commit-hook
          (lambda () (save-buffers-kill-terminal)))

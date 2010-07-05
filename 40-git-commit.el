(autoload 'git-commit-mode "git-commit" nil t)

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))

(add-hook 'git-commit-commit-hook
          (lambda () (save-buffers-kill-terminal)))

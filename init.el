(defvar emacs-conf-path
  "~/.emacs.d"
  "The full path to the emacs config directory")

(dolist (file (directory-files emacs-conf-path t "^[0-9]+.*\\.el$"))
  (let* ((compiled-file (concat file "c"))
         (loaded-elc (ignore-errors (load compiled-file))))
    (when (not loaded-elc)
      (message (format "failed to load %s - falling back to %s" compiled-file file))
      (load file))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:height 100 :foundry "bitstream" :family "Bitstream Vera Sans Mono"))))
 '(cperl-array-face ((((class color) (background light)) (:foreground "yellow"))))
 '(cperl-hash-face ((((class color) (background light)) (:foreground "brightcyan"))))
 '(cperl-invalid-face default)
 '(flymake-errline ((((class color) (background light)) (:background "brightred" :weight bold))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "darkgrey")))))

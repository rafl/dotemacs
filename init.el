(defvar emacs-conf-path
  "~/.emacs.d"
  "The full path to the emacs config directory")

(dolist (file (directory-files emacs-conf-path t "^[0-9]+.*\\.el$"))
  (load file))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((c-indentation-style . bsd)))))

;; FIXME: this is pretty fucked up for a cli emacs. especially on dark
;; background
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono"))))
 '(cperl-array-face ((((class color) (background light)) (:foreground "yellow4"))))
 '(cperl-hash-face ((((class color) (background light)) (:foreground "cyan3"))))
 '(cperl-invalid-face default)
 '(erc-current-nick-face ((t (:foreground "green3" :weight bold))))
 '(flymake-errline ((((class color) (background light)) (:background "brightred" :weight bold))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "orchid3"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "firebrick1"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "purple4" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "red2"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "orange"))))
 '(hl-line ((t (:inherit highlight :background "DarkSeaGreen1"))))
 '(rcirc-dim-nick ((t (:inherit default :foreground "grey" :strike-through t))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "darkgrey")))))

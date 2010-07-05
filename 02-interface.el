;; disable some ui components
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)

;; stop cursor from blinking
(blink-cursor-mode 0)

;; no welcome message
(setq inhibit-startup-message t)

;; no echo area help on startup
(defun display-startup-echo-area-message ()
  (message ""))

;; display position in modeline
(setq line-number-mode t)
(setq column-number-mode t)

;; syntax highlighting everywhere
(global-font-lock-mode t)

;; show matching parnens (mixed style)
(show-paren-mode t)
(setq show-paren-delay 0.0)
(setq show-paren-style 'parenthesis)

;; hilight selection
(transient-mark-mode t)

;; make "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; custom colors
(set-background-color "white")
(set-foreground-color "black")

;; switching
(iswitchb-mode 1)
(icomplete-mode 1)

;; no backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; case insensitive completion
(setq completion-ignore-case t)

;; always indent new lines by default
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq require-final-newline 'visit-save)

;; mouse stuff
(setq
 mouse-1-click-in-non-selected-windows nil
 mouse-yank-at-point t)
(mouse-avoidance-mode 'exile)

(setq-default indicate-empty-lines t)

;; do not show trailing ws by default, but whenever some buffer
;; changes its major mode, enable it if the buffer is visiting a file
(setq-default show-trailing-whitespace nil)
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (buffer-file-name)
              (setq show-trailing-whitespace t))))

(setq fill-column 80)

;; FIXME: doesn't work anymore
(highlight-beyond-fill-column)

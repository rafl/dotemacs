(setq
 eshell-buffer-name "*shell*"
 eshell-banner-message ""
 eshell-cmpl-autolist t
 eshell-cmpl-restore-window-delay 0
 eshell-error-if-no-glob t
 eshell-history-size 3000
 eshell-hist-ignoredups t
 eshell-visual-commands
 '("vi" "vim" "screen" "top" "htop" "less" "more" "lynx"
   "ncftp" "pine" "tin" "trn" "elm" "iftop" "jnettop"
   "mplayer"))

;; TODO: make visual-commands use ansi-term instead of term

(defun eshell/perldoc (&rest args)
  (perldoc (apply 'eshell-flatten-and-stringify args)))

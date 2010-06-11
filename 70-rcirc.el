(require 'rcirc)
(require 'rcirc-late-fix)

(add-hook 'rcirc-mode-hook
          (lambda ()
            (rcirc-track-minor-mode)
            (flyspell-mode t)
            (setq show-trailing-whitespace nil)
            (set (make-local-variable 'scroll-conservatively) 8192)))

(setq
 rcirc-debug-flag t
 rcirc-time-format "%H:%M:%S ")

(defun rafl-rcirc-connect (port)
  (rcirc-connect "localhost" port nil nil rafl-irc-password)
  (setq rcirc-server-name (rafl-irc-networks-port-to-network port)))

(defun rafl-rcirc-connect-all ()
  (interactive)
  (dolist (network rafl-irc-networks)
    (rafl-rcirc-connect (car network))))

(defvar rafl-irc-dynamic-fill-column-margin 3)

(defun rafl-irc-dynamic-fill-column-window (window &optional margin)
  (with-current-buffer (window-buffer window)
    (when (eq major-mode 'rcirc-mode)
      (setq fill-column
            (- (window-width window)
               (or margin rafl-irc-dynamic-fill-column-margin))))))

(defun rafl-irc-dynamic-fill-column (frame)
  (walk-windows 'rafl-irc-dynamic-fill-column-window 'no-minibuf frame))

(add-to-list 'window-size-change-functions 'rafl-irc-dynamic-fill-column)

(defadvice rcirc-format-response-string (after dim-entire-line)
  (when (and rcirc-dim-nicks sender
             (string-match (regexp-opt rcirc-dim-nicks 'words) sender))
    (setq ad-return-value (rcirc-facify ad-return-value 'rcirc-dim-nick))))

(ad-activate 'rcirc-format-response-string)

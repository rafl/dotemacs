(require 'rcirc)
(require 'rcirc-late-fix)

(add-hook 'rcirc-mode-hook
          (lambda ()
            (flyspell-mode t)
            (setq show-trailing-whitespace nil)
            (set (make-local-variable 'scroll-conservatively) 8192)))

(setq
 rcirc-debug-flag t
 rcirc-time-format "%H:%M:%S ")

(defvar rafl-irc-networks nil
  "a list of my irc ports and their network names")

(defvar rafl-irc-password nil
  "the password to be used when connecting to any of my irc networks")

(defun rafl-irc-networks-port-to-network (port)
  (dolist (network rafl-irc-networks)
    (if (= port (car network))
        (return (cadr network)))))

(defun rafl-irc-networks-network-to-port (network)
  (dolist (var rafl-irc-networks)
    (if (string= network (cadr var))
        (return (car var)))))

(defun rafl-irc-connect (port)
  (rcirc-connect "localhost" port nil nil rafl-irc-password)
  (setq rcirc-server-name (rafl-irc-networks-port-to-network port)))

(defun rafl-irc-connect-all ()
  (dolist (network rafl-irc-networks)
    (rafl-irc-connect (car network))))

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

(rcirc-track-minor-mode)

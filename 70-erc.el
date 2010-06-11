(require 'erc)
(require 'erc-networks)

(add-hook 'erc-mode-hook
          (lambda ()
            (flyspell-mode t)
            (setq show-trailing-whitespace nil)
            (set (make-local-variable 'scroll-conservatively) 8192)))

(defun erc-determine-network ()
  (intern (rafl-irc-networks-port-to-network erc-session-port)))

(defun rafl-erc-connect (port)
  (erc :server   "localhost"
       :port     port
       :password rafl-irc-password))

(defun rafl-erc-connect-all ()
  (interactive)
  (dolist (network rafl-irc-networks)
    (rafl-erc-connect (car network))))

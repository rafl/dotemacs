(require 'erc)
(require 'erc-networks)

(defvar rafl-irc-networks nil
  "a list of my irc ports and their network names")

(defvar rafl-irc-password nil
  "the password to be used when connecting to any of my irc networks")

(defun rafl-irc-networks-port-to-network (port)
  (dolist (network rafl-irc-networks)
    (if (= (car network) port)
        (return (car (cdr network))))))

(defun rafl-irc-networks-network-to-port (network)
  (dolist (var rafl-irc-networks)
    (if (string-equal (car (cdr var)) network)
        (return (car var)))))

(defun rafl-erc-connect (server port pass)
  (erc :server server :port port :password pass))

(defun rafl-erc-connect-all ()
  (dolist (network rafl-irc-networks)
    (rafl-erc-connect "localhost" (car network) rafl-irc-password)))

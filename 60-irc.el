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

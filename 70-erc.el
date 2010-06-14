(require 'erc)
(require 'erc-bbdb)
(require 'erc-networks)

;; don't use the NETWORK declared by the server or the server hostname
;; as the name of the network. instead, ask
;; `rafl-irc-networks-port-to-network'.
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

;; make queries as important as someone else mentioning your nick in a
;; channel
(defadvice erc-track-find-face (around rafl-erc-highlight-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value 'erc-current-nick-face)
    ad-do-it))

(setq
 erc-auto-query 'bury
 erc-autoaway-idle-method 'user
 erc-autoaway-message "I'm gone"
 ;; I'd actually like for bbdb to store stuff on join and nick changes
 ;; too, but it sometimes wants to be interactive when creating new
 ;; records, so this is turned off by default.
 erc-bbdb-auto-create-on-join-p nil
 erc-bbdb-auto-create-on-nick-p nil
 erc-bbdb-auto-create-on-whois-p t
 erc-fill-column 92
 erc-hide-list '("JOIN" "PART" "QUIT")
 erc-join-buffer 'bury
 erc-keyword '("Ragwitz" "FLORA")
 erc-kill-buffer-on-part t
 erc-kill-server-buffer-on-quit t
 erc-max-buffer-size 80000
 erc-modules
 '(autoaway autojoin button completion fill irccontrols list match menu
   move-to-prompt netsplit networks noncommands readonly ring
   scrolltobottom stamp spelling track truncate bbdb)
 erc-query-display 'bury
 erc-timestamp-format "[%H:%M:%S]"
 erc-timestamp-format-right " [%H:%M:%S]"
 erc-track-exclude-server-buffer t
 erc-track-exclude-types
 '("JOIN" "NICK" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" "477")
 erc-track-faces-priority-list '(erc-current-nick-face erc-keyword-face)
 erc-track-minor-mode t
 erc-track-position-in-mode-line t
 erc-track-priority-faces-only
 '("#mongodb" "#dbix-class" "#debian-perl" "#perlde" "#idlerpg" "#idleRPG"
   "#rt" "#austria.pm" "#musicbrainz-devel" "#poe" "##kernel" "#perlrdf"
   "#mogilefs")
 erc-track-shorten-start 2
 erc-track-switch-direction 'importance
 erc-truncate-mode t
 erc-whowas-on-nosuchnick t)

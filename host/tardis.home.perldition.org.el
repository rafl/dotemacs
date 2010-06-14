(let ((screen-name "irc-tunnel"))
  (when (not (screen-startedp screen-name))
    (screen-start-detached-with-screenrc screen-name (concat emacs-conf-path "/host/tardis.home.perldition.org/start-irc-tunnel.screenrc"))))

(setf rafl-irc-networks
      '((4041 "oftc")
        (4042 "magnet")
        (4043 "freenode")
        (4044 "zuhl")
        (4045 "bitlbee")))

;; don't worry about this being public. the proxies on goatse only
;; bind to localhost, and connections are being tunneled. all the
;; other users on goatse can be trusted, RIGHT?!
(setf rafl-irc-password "zqym-sxmh")

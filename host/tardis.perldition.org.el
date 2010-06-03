(let ((screen-name "irc-tunnel"))
  (when (not (screen-startedp screen-name))
    (screen-start-detached-with-screenrc screen-name (concat emacs-conf-path "/host/tardis.perldition.org/start-irc-tunnel.screenrc"))))

(setf rafl-irc-networks
      '((4041 "oftc")
        (4042 "magnet")
        (4043 "freenode")
        (4044 "zuhl")
        (4045 "bitlbee")))

(setf rafl-irc-password "zqym-sxmh")
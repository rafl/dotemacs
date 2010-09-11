(bbdb-initialize 'gnus 'message ''reportmail 'supercite 'w3)

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

(setq
 bbdb-north-american-phone-numbers-p nil
 bbdb-check-zip-codes-p nil
 bbdb-use-pop-up nil)

;;; bbdb-always-add-addresses
;; bbdb-ignore-{most,some}-messages-hook

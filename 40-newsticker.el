(setq
 newsticker-html-renderer 'w3m-region
 newsticker-date-face '((t (:slant italic :height 1.0 :family "helvetica")))
 newsticker-extra-face '((t (:foreground "gray50" :slant italic :height 1.0)))
 newsticker-feed-face '((t (:foreground "black" :weight bold :height 1.3)))
 newsticker-new-item-face '((t (:weight bold :family "helvetica"))))

(let ((feeds-file (mapconcat
                   'identity
                   (list emacs-conf-path "newsticker-feeds.el")
                   "/")))
  (when (not (ignore-errors (load feeds-file)))
    (message "Failed to load newsticker feeds from %s" feeds-file)))

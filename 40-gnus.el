(setq
 gnus-secondary-select-methods '((nnimap "perldition"
                                         (nnimap-address "imap.perldition.org")
                                         (nnimap-server-port 143)
                                         (nnimap-stream starttls)))

 ;;; display threads in the summary buffer in a way humans can understand. for
 ;;; example like this:
 ;;
 ;; O   14.07.2010 21:40  Nicholas Clark   Re: Directions of perl 5 development
 ;; O   15.07.2010 16:46  Steffen Schwigo  ├►
 ;; O   15.07.2010 17:09  Nicholas Clark   │├►
 ;; O   17.07.2010 15:15  Steffen Schwigo  ││├►
 ;; O   17.07.2010 18:30  Ævar Arnfjörð B  ││└►
 ;; O   17.07.2010 22:14  chromatic        ││ ├►
 ;; O   18.07.2010 07:34  Joshua ben Jore  ││ └►
 ;; O   15.07.2010 20:36  Jesse Vincent    │└►
 ;; O   15.07.2010 17:37  Dave Rolsky      └►

 gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f %* %B%s%)\n"
 gnus-user-date-format-alist '((t . "%d.%m.%Y %H:%M"))
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
 gnus-thread-sort-functions '(gnus-thread-sort-by-date)
 gnus-sum-thread-tree-root ""
 gnus-sum-thread-tree-false-root ""
 gnus-sum-thread-tree-indent " "
 gnus-sum-thread-tree-vertical "│"
 gnus-sum-thread-tree-leaf-with-other "├► "
 gnus-sum-thread-tree-single-leaf "└► "

 ;; "INBOX" instead of "nnimap+perldition:INBOX"
 gnus-group-line-format "%M%S%p%P%5y:%B%(%G%)%O\n")

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

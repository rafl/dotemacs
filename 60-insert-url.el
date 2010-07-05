(defun insert-url (url)
  (interactive
   (list (read-string "URL: ")))
  (let ((buf (url-retrieve-synchronously url)))
    (when buf
      (insert
       (or (with-current-buffer buf
             (goto-char (point-min))
             (when (re-search-forward "\n\n" nil t)
               (buffer-substring (match-end 0) (point-max))))
           ""))
      (kill-buffer buf))))

(defun find-url (url)
  (interactive
   (list (read-string "URL: ")))
  (with-current-buffer (get-buffer-create url)
    (if (not (ignore-errors (insert-url url)))
        (kill-buffer)
      (pop-to-buffer (current-buffer)))))

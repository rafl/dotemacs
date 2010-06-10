(let* ((host (system-name))
       (file (concat emacs-conf-path "/host/" host ".el")))
  (if (file-exists-p file)
      (progn (load file))))

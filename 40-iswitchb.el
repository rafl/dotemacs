(require 'edmacro)

(defun iswitchb-local-keys ()
  (mapc (lambda (k)
          (let* ((key (car k))
                 (fun (cdr k)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
        '(("<right>" . iswitchb-next-match)
          ("<left>"  . iswitchb-prev-match))))

(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)
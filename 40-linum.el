;(require 'linum)
;(global-linum-mode 1)

; the default, except with right alignment
(setq linum-format
      (lambda (line)
        (propertize
         (format
          (let ((w (length (number-to-string
                            (count-lines (point-min) (point-max)))))
                (sep (if (string-equal (window-system) "x") "" " ")))
            (concat "%" (number-to-string w) "d" sep))
          line)
         'face 'linum)))

(defvar rafl:buffer-settings)
(setq rafl:buffer-settings
      '((((:not ((:mode "^gnus") (:mode w3m-mode) (:mode "^erc"))))
         (lambda () (highlight-beyond-fill-column)))
        (((:mode message-mode)
          (:mode org-mode)
          (:mode pod-mode)
          (:mode markdown-mode)
          (:name "\\.\\(txt\\|mkn\\)$"))
         (lambda ()
           (flyspell-mode 1)
           (auto-fill-mode 1)))
        (((:project "perl"))
         (lambda ()
           (when (save-excursion
                   (goto-char (point-min))
                   (re-search-forward "\t" nil t))
             (setq
              tab-width 8
              indent-tabs-mode t))))
        (((:project "Sub-Name"))
         (lambda ()
           (setq
            tab-width 8
            indent-tabs-mode t
            c-basic-offset 8)))))

(defun rafl:evaluate-buffer-condition (con)
  (cond
   ((functionp con)
    (funcall con))
   ((listp con)
    (cond
     ((listp (car con))
      (reduce
       (lambda (a b) (or a b))
       (mapcar #'rafl:evaluate-buffer-condition con)
       :initial-value nil))
     (t
      (reduce
       (lambda (a b) (and a b))
       (let (ret)
         (while con
           (let ((k (pop con))
                 (v (pop con)))
             (push (cond
                    ((eq k :fun)
                     (funcall v))
                    ((eq k :not)
                     (when (not (listp v))
                       (error ":not requires a list"))
                     (not (rafl:evaluate-buffer-condition v)))
                    ((eq k :mode)
                     (if (stringp v)
                         (string-match-p v (symbol-name major-mode))
                       (eq v major-mode)))
                    ((eq k :name)
                     (cond
                      ((and (buffer-file-name) (stringp v))
                       (string-match-p v (buffer-file-name)))
                      ((buffer-file-name)
                       v)
                      (t
                       (not v))))
                    ((eq k :project)
                     ;; assume eproject-maybe-turn-on was called from an earlier
                     ;; hook
                     (cond
                      ((and eproject-root (stringp v))
                       (string= v (eproject-name)))
                      (eproject-root
                       v)
                      (t
                       (not v))))
                    (t
                     (error "unknown cond")))
                   ret)))
         ret)
       :initial-value t))))
   (t
    (error "invalid condition"))))

(defun rafl:apply-buffer-settings (settings)
  (dolist (setting rafl:buffer-settings)
    (let ((condition (car setting))
          (action (cadr setting)))
      (when (rafl:evaluate-buffer-condition condition)
        (funcall action)))))

(add-hook 'after-change-major-mode-hook
          (lambda () (rafl:apply-buffer-settings rafl:buffer-settings))
          'append)

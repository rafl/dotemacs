(require 'eproject)

(dolist (func '(eproject-compile
                eproject-eshell-cd-here
                eproject-multi-isearch-buffers
                eproject-todo
                eproject-grep
                eproject-revisit-project
                eproject-project-root
                eproject-open-all-project-files
                eproject-kill-project-buffers
                eproject-ibuffer
                eproject-find-file
                eproject-ifind-file))
  (autoload func "eproject-extras"))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (not eproject-root))
              (eproject-maybe-turn-on))))

(define-project-type perl (generic)
  (or (look-for "dist.ini") (look-for "Makefile.PL") (look-for "Build.PL"))
  :relevant-files ("\\.pm$" "\\.pod$" "\\.t$""\\.pl$" "\\.PL$" "\\.ini$"
                   "Changes" "ChangeLog")
  :irrelevant-files ("inc/" "blib/" ".build/" "cover_cb/" "\\.tar\\.gz$")
  :file-name-map (lambda (root)
                   (lambda (root file)
                     (cond ((string-match "^lib/\\(.+\\)[.]\\(pm|pod\\)$" file)
                            (let ((m (string-match 1 file)))
                              (while (string-match "/" m)
                                (setf m (replace-match "::" nil nil m)))
                              m))
                           (t file))))
  :main-file "dist.ini")

(defmacro .emacs-curry (function &rest args)
  `(lambda () (interactive)
     (,function ,@args)))

(defmacro .emacs-eproject-key (key command ep-only)
  (cons 'progn
        (loop for (k . p) in (list (cons key 4) (cons (upcase key) 1))
              collect
              `(,@(if ep-only '(define-key eproject-mode-map) '(global-set-key))
                (kbd ,(format "C-x p %s" k))
                (.emacs-curry ,command ,p)))))

(.emacs-eproject-key "k" eproject-kill-project-buffers t)
(.emacs-eproject-key "v" eproject-revisit-project nil)
(.emacs-eproject-key "b" eproject-ibuffer t)
(.emacs-eproject-key "o" eproject-open-all-project-files t)

(defvar rafl-per-project-settings nil "rafl's per-project buffer settings")
(setq rafl-per-project-settings
      '(("perl"
         (lambda ()
                  (when (save-excursion
                          (goto-char (point-min))
                          (re-search-forward "\t" nil t))
                    (message "moo")
                    (setq
                     tab-width 8
                     indent-tabs-mode t)))
         (lambda ()
           (when (eq major-mode 'c-mode)
             (setq
              c-indentation-style 'bsd
              c-basic-offset 4))))
        ("git"
         ((indent-tabs-mode t)))
        ("xmms2"
         ((c-basic-offset 4)
          (c-indentation-style 'bsd)))))

(defun rafl-apply-buffer-settings-for-project (project)
  (let ((settings (cdr (assoc project rafl-per-project-settings))))
    (loop for setting in settings
          do (if (functionp setting)
                 (funcall setting)
               (apply #'set setting)))))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (not eproject-root)
                       (eproject-maybe-turn-on))
              (rafl-apply-buffer-settings-for-project (eproject-name)))))

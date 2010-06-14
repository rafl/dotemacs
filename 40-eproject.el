(require 'eproject)
(require 'eproject-extras)

(define-project-type perl (generic)
  (or (look-for "dist.ini") (look-for "Makefile.PL") (look-for "Build.PL"))
  :relevant-files ("\\.pm$" "\\.pod$" "\\.t$" "\\.pl$" "\\.PL$" "dist\\.ini$")
  :irrelevant-files ("inc/" "blib/" ".build/" "cover_cb/")
  :file-name-map (lambda (root)
                   (lambda (root file)
                     (cond ((string-match "^lib/\\(.+\\)[.]\\(pm|pod)$" file)
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

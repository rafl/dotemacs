(defalias 'perl-mode 'cperl-mode)

(setq
 cperl-tab-always-indent t
 cperl-indent-left-aligned-comments t
 cperl-auto-newline nil
 cperl-close-paren-offset -4
 cperl-indent-level 4
 cperl-indent-parens-as-block t
 cperl-continued-statement-offset 4
 cperl-indent-subs-specially nil
 cperl-invalid-face 'underline)

(custom-set-faces
 '(cperl-invalid-face default))

(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))

(require 'flymake)

(add-hook 'cperl-mode-hook
          (lambda () (flymake-mode 1)))

(defadvice flymake-perl-init (around flymake-eproject-perl5lib)
  (let* ((project-root (ignore-errors (eproject-maybe-turn-on)))
         (ret ad-do-it)
         (args (cadr ret)))
    (when project-root
      (setcdr ret (list (cons (concat "-I" project-root "lib") args))))
    ret))

(ad-activate 'flymake-perl-init)

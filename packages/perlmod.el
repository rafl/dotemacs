;;; perlmod.el --- Open the source code of an installed perl module

;; This software is Copyright (c) 2010 by Florian Ragwitz.
;;
;; This is free software, licensed under:
;;   The GNU General Public License, Version 2, June 1991

;; Author: Florian Ragwitz <rafl@debian.org>
;; Version: 0.2
;; Keywords: perl

;;; Commentary:
;;

;;; Code:

(require 'perldoc)

(defun perlmod-open (module)
  "Visit a perl module.
This starts a perl process loading MODULE to figure out the file
that contains the module, and calls `find-file' on the resulting
filename."
  (let* ((default-directory "/")
         (proc (start-process
                "perlmod" nil
                "perl" (concat "-m" module) "-e"
                (concat "my $mod = $ARGV[0]; $mod =~ s{::}{/}g;"
                        "$mod .= q{.pm}; print $INC{$mod}")
                module)))
    (set-process-plist proc (list :output ""))
    (set-process-filter
     proc (lambda (proc str)
            (let ((plist (process-plist proc)))
              (plist-put plist
                         :output (concat (plist-get plist :output) str)))))
    (set-process-sentinel
     proc (lambda (proc event)
            (let ((output (plist-get (process-plist proc) :output)))
              (if (and
                   (eq (process-status proc) 'exit)
                   (string-bytes output))
                  (find-file output)
                (message "Module not found.")))))))

;;;###autoload
(defun perlmod (&optional module re-cache)
  "Open a perl MODULE.
If RE-CACHE, which defaults to `current-prefix-arg', is non-nil,
an update of the cache for module names is forced."
  (interactive (list nil current-prefix-arg))
  (when (or re-cache (not perldoc-modules-alist))
    (message "Building completion list of all perl modules...")
    (perldoc-modules-alist t))
  (unless (stringp module)
    (setq module
          (completing-read "Perl module: " (perldoc-modules-alist) nil nil)))
  (cond
   ((stringp module)
    (perlmod-open module))
   (t
    (message "Nothing to find."))))

(provide 'perlmod)

;;; perlmod.el ends here

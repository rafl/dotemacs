;;; nopaste.el --- interface to nopaste.pl

;; Copyright (C) 2007, 2010 Ævar Arnfjörð Bjarmason

;; Author: Ævar Arnfjörð Bjarmason <avar@cpan.org>
;; Created: 2007-11-22
;; Keywords: comm

;; This file is not a part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Interfaces with paste bots via the `nopaste' which is part of the
;; `App::Nopaste' CPAN distribution found at
;; http://github.com/sartak/app-nopaste

;; Example usage with a custom path and nick:

;; (require 'nopaste)
;; (setq nopaste-nick "avar")

;; The recommended keybindings are:
;;
;; (global-set-key (kbd "C-c n p") 'nopaste)
;; (global-set-key (kbd "C-c n y") 'nopaste-yank-url)

;;; Code:


;; Public variables
(defvar nopaste-nickname ""
  "The nick given to nopaste")
(defvar nopaste-description ""
  "The description given to nopaste")
(defvar nopaste-channel ""
  "The channel given to nopaste")
(defvar nopaste-language ""
  "The the language given to nopaste")
(defvar nopaste-service ""
  "The nopaste service to use. This can also be set through the
  NOPASTE_SERVICES environmental variable to be read by nopaste
  itself.")

(defvar nopaste-command "nopaste"
  "The nopaste command name. Will use `nopaste' in your system's
  $PATH by default")

;; Internal variables
(defvar nopaste-prev-description ""
  "The last description provided. For internal use")
(defvar nopaste-prev-channel nil
  "The last channel provided or `nil' if none. For internal use")

(defvar nopaste-last-url nil "The last URL from the paste server")
(defvar nopaste-kill-last-url t
  "Whether to `kill-new' the URL we get to make it available in
the kill ring")

(defun nopaste (&optional start end nickname description channel)
  "Nopaste either the currently active region or the entire
buffer. If `region-active-p' is true we'll paste the region,
otherwise we'll paste the buffer from `point-min' to
`point-max'."
  (interactive "r")
  (when (not (region-active-p))
    (setq start (point-min) end (point-max)))
  (nopaste-region start end nickname description channel))

(defun nopaste-region (start end &optional nickname description channel)
  "Nopaste a given region, nopaste will be called with
`call-process-region'."
  (interactive "r")
  (let* ((nickname (or nickname nopaste-nickname  (read-from-minibuffer "Nick: " nopaste-nickname)))
        (description (and nopaste-description (read-from-minibuffer "Description: " nopaste-prev-description)))
        (channel (and nopaste-channel (or channel (read-from-minibuffer "Channel: " (or nopaste-prev-channel nopaste-channel)))))
        (service nil)
        (language nil)
        (args
         (append
          (and nickname (list "--name" nickname))
          (and channel (list "--channel" channel))
          (and description (list "--description" description))
          (and service (list "--service" service))
          (and language (list "--language language")))))

    (setq nopaste-prev-description description)
    (setq nopaste-prev-channel channel)

    (let ((current-buffer-name (buffer-name)))
      (with-temp-buffer
        (let ((temp-buffer-name (buffer-name)))
          (set-buffer current-buffer-name)

          ;; Call nopaste
          (let ((exit-value (apply 'call-process-region start end "nopaste" nil temp-buffer-name t args)))
            (if (numberp exit-value)
              (cond
               ((eq 0 exit-value))
               (t (error "nopaste failed with exit value %d" exit-value)))
              (error "nopaste failed failed: %s" exit-value)))

          (set-buffer temp-buffer-name)
          (let ((url (-nopaste-chomp (buffer-string))))
            (message "Got URL %s from nopaste" url)
            (when nopaste-kill-last-url
              (kill-new url))
            (setq nopaste-last-url url)))))))


(defun nopaste-yank-url ()
  "Insert the URL of the last nopaste at point"
  (interactive)
  (insert nopaste-last-url))

(defun -nopaste-chomp (str)
  "If there's a \n$, kill it"
  (if (equal (elt str (- (length str) 1)) ?\n)
      (substring str 0 (- (length str) 1))
    str))

(provide 'nopaste)

;;; nopaste.el ends here

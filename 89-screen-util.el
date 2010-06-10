(require 'cl)

(defun ensure-autossh-installed ()
  "'error' if autossh isn't installed on the system"
  (case (shell-command "autossh -V")
        (0)
        (127 (error "autossh not installed. tunneling won't work"))))

(defun screen-start-detached-with-screenrc (screen-name screen-rc)
  "Start a screen instance of a given name with a screenrc. Assumes the screenrc will detach"
  (ensure-autossh-installed)
  (let* ((screen-command (concat "screen -m -d -S " screen-name " -c " screen-rc))
         (ret (shell-command screen-command)))
    (when (not (zerop ret))
      (error (concat "Screen `" screen-name "' failed with error " (number-to-string ret))))))

(defun screen-startedp (screen-name)
  "Checks if a screen session with the given name exists"
  (let ((command (concat "screen -ls |grep -c '\\." screen-name "'")))
    (not (zerop (string-to-number (shell-command-to-string command))))))

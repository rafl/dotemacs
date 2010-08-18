(autoload 'color-theme-rafl "color-theme-rafl" nil t)
(setq color-theme-is-global nil)

;; this is for normal startup
(when (eq (window-system) 'x)
  (color-theme-rafl))

;; this is for creating new emacsclient frames
(add-hook
 'after-make-frame-functions
 (lambda (frame)
   (when (eq (window-system frame) 'x)
     (select-frame frame)
     (color-theme-rafl))))

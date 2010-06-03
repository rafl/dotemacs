(require 'pod-mode)
(setq auto-mode-alist (append auto-mode-alist '(("\\.pod$" . pod-mode))))

;(require 'weaver-mode)
;(defalias 'pod-mode 'weaver-mode)
;(setq auto-mode-alist (cons '("\\.pod$" . weaver-mode) auto-mode-alist))

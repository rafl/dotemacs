(add-hook 'after-init-hook 'session-initialize)

(setq session-initialize '(de-saveplace session places))

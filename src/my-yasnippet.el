;; Yasnippet
(require 'yasnippet)
(load "snippet-helpers.el")
(setq yas/root-directory
      `(,(concat emacs-dir "/snippets")))
(mapc 'yas/load-directory yas/root-directory)
(setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
(setq yas-wrap-around-region 'cua)
(yas-global-mode)
; Disable in term-mode
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))


;(add-hook 'after-change-major-mode-hook
;          (lambda () (add-to-list 'ac-sources 'ac-source-yasnippet)))

(provide 'my-yasnippet)

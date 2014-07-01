;;; clojure-dev --- Settings for python development
;;; Commentary:
;;; Provides settings for javacscript development

;;; Code:
(require 'cider)
(require 'ac-nrepl)
(require 'nrepl-client)
(require 'clojure-test-mode)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-show-error-buffer 'only-in-repl)

;; AC
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defun set-auto-complete-as-completion-at-point-function
  ()
  "Set auto complete as completion at point function."
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook
          'set-auto-complete-as-completion-at-point-function)

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;; Auto reload
(defun clojure-test-reload-and-run-test ()
  "Reload namespaces and run test."
  (interactive)
  (nrepl-send-string-sync
   "(refresh)")
  (clojure-test-run-tests))
(add-hook 'cider-mode-hook
          (lambda ()
            (nrepl-send-string-sync
             "(use '[clojure.tools.namespace.repl :only (refresh)])")
            (local-set-key (kbd "<f6>")
                                     'clojure-test-reload-and-run-test)))

(provide 'clojure-dev)
;;; clojure-dev.el ends here

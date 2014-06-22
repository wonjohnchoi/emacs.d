;;; clojure-dev --- Settings for python development
;;; Commentary:
;;; Provides settings for javacscript development

;;; Code:
(require 'cider)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer 'only-in-repl)

(provide 'clojure-dev)
;;; clojure-dev.el ends here

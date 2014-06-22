;;; javascript-dev --- Settings for javascript development
;;; Commentary:
;;; Provides settings for javacscript development

;;; Code:
(require 'flycheck)

(flycheck-define-checker javascript-jslint-reporter
  "A JavaScript syntax and style checker based on JSLint Reporter.

See URL `https://github.com/FND/jslint-reporter'."
  :command ("~/.emacs.d/js-libs/jslint-reporter" source)
  :error-patterns
  ((error line-start (1+ nonl) ":" line ":" column ":" (message) line-end))
  :modes (js-mode js2-mode js3-mode))
(add-hook 'js-mode-hook (lambda ()
                          (flycheck-select-checker 'javascript-jslint-reporter)))

(provide 'javascript-dev)
;;; javascript-dev.el ends here

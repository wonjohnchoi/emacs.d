;;; init --- Init
;;; Commentary:
;;; My Emac init settings

;;; Code:
(setq auto-save-default nil)
(setq debug-on-error t)
(defvar flycheck-emacs-lisp-load-path)
(defun flycheck-load-path-hook ()
  "Customization for flycheck."
  (setq flycheck-emacs-lisp-load-path load-path))

(add-hook 'flycheck-before-syntax-check-hook #'flycheck-load-path-hook)
(add-to-list 'load-path (concat (file-name-directory load-file-name) "src"))

;; Add .emacs to emacs-lisp-mode
(add-to-list 'auto-mode-alist '(".emacs\\'" . emacs-lisp-mode))

(add-to-list 'load-path "~/.cask")

;; Load packages
(require 'cask)
(cask-initialize)
(require 'utils)
(require 'platforms)
(require 'packages)

;;;; Theme
(require 'theme)

;; Commons
(require 'backup)
(require 'commons)
(require 'keys)
(require 'scroll)

;;;; Development
(require 'dev)
;(require 'javascript-dev)
;(require 'python-dev)
;(require 'cpp-dev)
;(require 'cuda-dev)
;(require 'java-dev)
;(require 'android-dev)
;(require 'clojure-dev)

;;; init.el ends here

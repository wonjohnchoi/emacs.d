;;; commons --- Common settings for convinience
;;; Commentary:

;;; Code:

;; Utils
(require 'utils)
;(require 'my-speedbar)
;(require 'my-tabbar)
;(require 'my-yasnippet)

;; Highlight brackets
(show-paren-mode t)

;; Disable Shift-space to language conversion
(global-unset-key (kbd "S-SPC"))

(require 'my-mouse)

;; UTF-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (defvar default-buffer-file-coding-system 'utf-8))
;; Term
(defadvice ansi-term (after advise-ansi-term-coding-system)
  "Ansi-term."
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(defvar x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Redo
; (require 'redo+)
; (global-set-key (kbd "C-u") 'undo)
; (global-set-key (kbd "C-r") 'redo)

;; ido
; (require 'ido)
; (ido-mode t)
; (setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; Linum
(require 'linum)
(global-linum-mode)
(setq linum-format "%3d ")

;; eww
(require 'eww)

(provide 'commons)
;;; commons.el ends here

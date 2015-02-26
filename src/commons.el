;;; commons --- Common settings for convinience
;;; Commentary:

;;; Code:

;; Utils
(require 'utils)
;(require 'my-speedbar)
;(require 'my-tabbar)

;; Highlight brackets
(show-paren-mode t)

;; Disable Shift-space to language conversion
(global-unset-key (kbd "S-SPC"))

;; Enable mouse
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
			       (interactive)
			       (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
			       (interactive)
			       (scroll-up 1)))
  (defun track-mouse (e))
  (defvar mouse-sel-mode)
  (setq mouse-sel-mode t))

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


(add-hook 'after-change-major-mode-hook
          (lambda () (add-to-list 'ac-sources 'ac-source-yasnippet)))


(provide 'commons)
;;; commons.el ends here

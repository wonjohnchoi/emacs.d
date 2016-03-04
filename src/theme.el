;;; theme --- Theme settings
;;; Commentary:
;;; Theme settings

;;; Code:

;; Solarized
(require 'utils)
(add-to-list 'custom-theme-load-path (join-paths emacs-dir "themes" "solarized"))
(load-theme 'solarized-dark t)
(load "fix-color.el")

;; Transparency
(defun transparency (value)
   "Set the transparency of the frame window with VALUE.  0=transparent/100=opaque."
   (interactive "Transparency Value 0 - 100 opaque:")
   (set-frame-parameter (selected-frame) 'alpha value))
(transparency 100)

(set-face-attribute 'default nil :foreground "white")
(set-face-attribute 'default nil :height 120)
(set-face-attribute 'header-line nil :foreground "white")
(set-face-attribute 'menu nil :foreground "white")


;; Font
(if (or platform-windows? platform-mac?)
    (set-face-attribute 'default nil :family (if platform-windows? "Consolas" "Monaco")))

(provide 'theme)
;;; theme.el ends here

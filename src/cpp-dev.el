;;; cpp-dev --- C/C++ dev settings
;;; Commentary:

;;; Code:
(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;;; show/hide ecb window
(global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
;;; quick navigation between ecb windows
(global-set-key (kbd "s-0") 'ecb-goto-window-edit1)
(global-set-key (kbd "s-1") 'ecb-goto-window-directories)
(global-set-key (kbd "s-2") 'ecb-goto-window-sources)
(global-set-key (kbd "s-3") 'ecb-goto-window-methods)
(global-set-key (kbd "s-4") 'ecb-goto-window-compilation)

;; Code convention
(defvar c-default-style)
(defvar c-basic-offset)
(setq c-default-style "linux")
(setq c-basic-offset 4)


;; Auto complete clang
(require 'auto-complete-clang)
(defun ac-clang-setup ()
  "Setup."
  (add-to-list 'ac-sources 'ac-source-clang))
(add-hook 'c-mode-common-hook 'ac-clang-setup)

;; Syntax check
(add-hook 'c-mode-common-hook 'flymake-mode-on)

;; Auto complete etags
(defun ac-etags-mode-setup ()
  "Setup."
  (when (require 'auto-complete-etags nil t)
    (add-to-list 'ac-sources 'ac-source-etags)
    (defvar ac-etags-use-document t)))
(add-hook 'c-mode-common-hook 'ac-etags-mode-setup)

(provide 'cpp-dev)
;;; cpp-dev.el ends here

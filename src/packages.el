;;; package --- Package settings
;;; Commentary:


;;; Code:

(require 'utils)

;; Add Cask to emacs-lisp-mode
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;; Load path
(defvar plugin-dir)
(setq plugin-dir (join-paths emacs-dir "plugin"))
(add-to-list 'load-path emacs-dir)
(add-to-list 'load-path plugin-dir)
(add-to-list 'load-path (join-paths emacs-dir "java-libs" "lisp"))
(when platform-mac? (add-to-list 'load-path
                                 "/usr/local/Cellar/gettext/0.18.3.1/share/emacs/site-lisp"))
(add-to-list 'custom-theme-load-path (join-paths emacs-dir "themes" "solarized"))

;; Load package
(when platform-windows? (setq package-user-dir (join-paths emacs-dir "elpa")))

(provide 'packages)
;;; packages.el ends here

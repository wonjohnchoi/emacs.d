;;; dev --- Common settings for development
;;; Commentary:
;;; Provides common settings for development like key bindings and etc...

;;; Code:

;; Magit
(require 'magit)
(global-set-key (kbd "<f12>") 'magit-status)

;; Scroll compile buffer
(setq compilation-scroll-output t)

;; Auto complete
(require 'auto-complete)
(require 'auto-complete-config nil t)
;; Do What I Mean mode
(setq ac-dwim t)
(ac-config-default)

;; custom keybindings to use tab, enter and up and down arrows
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)

;; Project mode
(autoload 'project-mode "project-mode" "Project Mode" t)

;; Key bindings
(global-set-key (kbd "<f7>") 'compile)

;; Delete trailing whitespace
(defvar delete-whitespace-modes-list
  (list 'emacs-lisp-mode 'python-mode 'c-mode 'c++-mode 'html-mode 'js-mode
        'jinja2-mode 'cuda-mode))
(defun delete-trailing-whitespace-by-mode ()
   "Delete trailing whitespaces if major mode want to do."
   (interactive)
   (when (member major-mode delete-whitespace-modes-list) (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'delete-trailing-whitespace-by-mode)

;; 80 Columns base
(require 'column-marker)

;; Flymake
(eval-after-load 'flymake '(require 'flymake-cursor))
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; SSH
(require 'tramp)
(require 'dired)
(setq tramp-default-method "ssh")
;; Enable sudo
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))
(defun sudo-edit-current-file ()
  "Edit this file with sudo."
  (interactive)
  (let ((my-file-name) ; fill this with the file to open
        (position))    ; if the file is already open save position
    (if (equal major-mode 'dired-mode) ; test if we are in dired-mode
        (progn
          (setq my-file-name (dired-get-file-for-visit))
          (find-alternate-file (prepare-tramp-sudo-string my-file-name)))
      (setq my-file-name (buffer-file-name); hopefully anything else is an already opened file
            position (point))
      (find-alternate-file (prepare-tramp-sudo-string my-file-name))
      (goto-char position))))


(defun prepare-tramp-sudo-string (tempfile)
  "Provide tramp sudo string with TEMPFILE."
  (if (file-remote-p tempfile)
      (let ((vec (tramp-dissect-file-name tempfile)))

        (tramp-make-tramp-file-name
         "sudo"
         (tramp-file-name-user nil)
         (tramp-file-name-host vec)
         (tramp-file-name-localname vec)
         (format "ssh:%s@%s|"
                 (tramp-file-name-user vec)
                 (tramp-file-name-host vec))))
    (concat "/sudo:root@localhost:" tempfile)))

(define-key dired-mode-map [s-return] 'sudo-edit-current-file)

(provide 'dev)
;;; dev.el ends here

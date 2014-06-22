;;; python-dev --- Settings for python development
;;; Commentary:
;;; Provides settings for javacscript development

;;; Code:
(require 'jedi)
(require 'python)
(require 'mmm-mode)
(require 'pyflakes)
(require 'virtualenv)

;; 80 Columns
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 79)))

;; pytest
(defvar pytest-cmd-flags "-x -v --capture=no")

;; Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(setq python-indent-offset 4)

;; Docstring
(setq mmm-global-mode 'maybe)
(defun rst-python-docstrings-find-front (bound)
  "RST support BOUND."
  (when (not bound)
    (setq bound (point-max))
  )
  (message "Start %s" (point))
  (loop while (< (point) bound) do
        (progn (message "Search at %s" (point))
               (when (re-search-forward "\\(\"\"\"\\|\'\'\'\\)" bound 'limit)
                 (let* ((start (match-beginning 0)))
                   (save-excursion (goto-char start)
                                   (save-match-data (python-nav-beginning-of-statement))
                                   (when (and (= (point) start)) (return (match-end 0)))))))))

(defun rst-python-docstrings-find-back (bound)
  "RST support BOUND."
  (when (not bound) (setq bound (point-max)))
  (loop while (< (point) bound) do
        (when (re-search-forward "\\(\"\"\"\\|\'\'\'\\)" bound t)
          (let* ((delim (match-string 0)))
            (save-excursion (save-match-data (python-nav-beginning-of-statement))
                            (when (looking-at-p delim) (return (match-end 0))))))))

(add-to-list 'mmm-save-local-variables 'adaptive-fill-regexp)
(add-to-list 'mmm-save-local-variables 'fill-paragraph-function)

(mmm-add-classes '((rst-python-docstrings
                    :submode rst-mode
                    :face mmm-comment-submode-face
                    :front rst-python-docstrings-find-front
                    :back rst-python-docstrings-find-back
                    :save-matches 1
                    :insert ((?d embdocstring nil @ "\"\"\"" @ _ @ "\"\"\"" @))
                    :delimiter-mode nil)))
;;;(assq-delete-all 'rst-python-docstrings mmm-classes-alist)

(mmm-add-mode-ext-class 'python-mode nil 'rst-python-docstrings)

;; Key bindings
(defun set-py-keys()
  (local-set-key (kbd "C-c d") 'jedi:show-doc))
(add-hook 'python-mode-hook 'set-py-keys)

(require 'utils)
(when platform-mac? (setq virtualenv-root "~/Development/py-envs"))

;; Python libraries
(let ((python-libs-path (join-paths emacs-dir "python-libs"))
      (python-path (getenv "PYTHONPATH")))
  (setenv "PYTHONPATH"
          (if python-path
              (concat python-path path-separator python-libs-path)
            python-libs-path))
  (setq jedi:server-args
        (append `("--sys-path" ,python-libs-path)
                (if platform-mac? '("--virtual-env"
                                    "~/Development/py-envs/meety") '()))))
(setenv "PYTHONSTARTUP" (join-paths emacs-dir
                                    "python-libs"
                                    "jedi"
                                    "replstartup.py"))
;; pdb
(defvar gud-pdb-command-name)
(setq gud-pdb-command-name
      (if platform-windows? "python -i -m pdb" "python -m pdb"))

(provide 'python-dev)
;;; python-dev.el ends here

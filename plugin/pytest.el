
(require 'term)

(defcustom pytest-project-root-files '("setup.py" ".hg" ".git")
  "Names of files or directories that signify the root of a
  project")

(defcustom pytest-project-root-test 'pytest-project-root
  "A function used to determine the directory the tests will be
  run from.")

(defcustom pytest-global-name "pytest"
  "The name of the py.test executable")

(defcustom pytest-cmd-flags "-x"
  "These are the flags passed to the pytest runner")

(defun pytest-term-sentinel (proc msg)
  (term-sentinel proc msg)
  (when (memq (process-status proc) '(signal exit))
    (save-excursion
      (set-buffer "*pytest*")
      (setq buffer-read-only t)
      (local-set-key "q" 'quit-window)
      (local-set-key "g" 'pytest))))

(defun pytest-posix-run (cmdline show-prompt)
  (let ((cmdline (if show-prompt
                     (read-shell-command "Run: " cmdline
                                         'pytest-run-history)
                   cmdline))
        (buffer (get-buffer-create "*pytest*")))
    (if (not (equal (current-buffer) buffer))
        (switch-to-buffer-other-window buffer))
    (if (get-buffer-process (current-buffer))
        (term-kill-subjob))
    (setq buffer-read-only nil)
    (erase-buffer)
    (insert cmdline)
    (newline)
    (term-ansi-make-term "*pytest*" "/bin/sh" nil "-c" cmdline)
    (term-char-mode)
    (let ((proc (get-buffer-process buffer)))
      ; override the default sentinel set by term-ansi-make-term
      (set-process-sentinel proc 'pytest-term-sentinel))))
(defun pytest-windows-run (cmdline show-prompt)
  (let ((cmdline (if show-prompt
                     (read-shell-command "Run: " cmdline
                                         'pytest-run-history)
                   cmdline))
        (buffer (get-buffer-create "*pytest*")))
    (if (not (equal (current-buffer) buffer))
        (switch-to-buffer-other-window buffer))
    (if (get-buffer-process (current-buffer))
        (term-kill-subjob))
    (setq buffer-read-only nil)
    (erase-buffer)
    (insert cmdline)
    (newline)
    (shell-command cmdline buffer)))

(defun pytest-windows ()
      "Run py.test on the current file or directory.

If the name of the current file matches test_*.py, run py.test on
it. Else, run py.test on the directory where the current file is in.
"
      (interactive)
      (let
	  ((cmdline (format "cd %s & py.test %s "
                            (pytest-find-project-root)
                            pytest-cmd-flags)))
	(pytest-windows-run cmdline t)))

(defun pytest-posix ()
  "Run py.test on the current file or directory.

If the name of the current file matches test_*.py, run py.test on
it. Else, run py.test on the directory where the current file is in.
"
  (interactive)
  (let*
      ((project-root (pytest-find-project-root))
       (cmdline (if project-root
                    (format "cd %s && py.test %s " project-root pytest-cmd-flags)
                  (format "py.test %s" pytest-cmd-flags))))
    (pytest-posix-run cmdline t)))
(if (eq system-type 'windows-nt)
    (defun pytest () (interactive) (pytest-windows))
  (defun pytest () (interactive) (pytest-posix)))

(defun pytest-find-project-root (&optional dirname)
  (let ((dn
         (if dirname
             dirname
           (file-name-directory buffer-file-name))))
    (cond ((funcall pytest-project-root-test dn) (expand-file-name dn))
          ((equal (expand-file-name dn) "/") nil)
        (t (pytest-find-project-root
             (file-name-directory (directory-file-name dn)))))))

(defun pytest-project-root (dirname)
  (reduce '(lambda (x y) (or x y))
          (mapcar (lambda (d) (member d (directory-files dirname)))
                  pytest-project-root-files)))

(provide 'pytest)

;;; utils --- Common utils
;;; Commentary:
;;; Common utils for my Emacs setting


;;; Code:

(defun is-in-terminal()
    (not (display-graphic-p)))

(defun file-basename (&optional filename)
  "Return the base name of the FILENAME: no directory, no extension.
FILENAME defaults to `buffer-file-name`."
  (file-name-sans-extension
   (file-name-nondirectory (or filename (buffer-file-name)))))

(defun join-paths (root &rest paths)
  "Join path components in posix-way like ROOT/PATHS/path/... ."
  (if (not paths)
      root
    (let ((path (car paths)))
      (if (and (> (length path) 0)
	       (string-equal (substring path 0 1) "/"))
	  (apply 'join-paths path (cdr paths))
	(if (or (= (length root) 0) (string-equal (substring root -1) "/"))
	    (apply 'join-paths (concat root path) (cdr paths))
	  (apply 'join-paths (concat root "/" path) (cdr paths)))))))

;; Platform specific variables
(defvar platform-windows? (eq system-type 'windows-nt))
(defvar platform-mac? (eq system-type 'darwin))
(defvar platform-linux? (eq system-type 'gnu/linux))
(setq package-archives (quote (("melpa" . "http://melpa.milkbox.net/packages/")
                               ("gnu" . "http://elpa.gnu.org/packages/")
                               ("Marmalade" . "http://marmalade-repo.org/packages/"))))

(defvar emacs-dir)
(unless (boundp 'emacs-dir)
  (setq-default emacs-dir (if platform-windows?
                              (join-paths (getenv "HOMEPATH") "Dropbox" "Dev" "emacs.d")
                            (expand-file-name "~/.emacs.d"))))
(when platform-windows? (add-to-list 'load-path emacs-dir))

;; File I/O
(defun write-string-to-file (string file)
  "Write STRING to FILE."
  (interactive "sEnter the string: \nFFile to save to: ")
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min) (point-max) file))))

(defun file-string (file)
    "Read the contents of a FILE and return as a string."
    (with-temp-buffer
      (insert-file-contents file)
      (buffer-string)))

(provide 'utils)
;;; utils.el ends here

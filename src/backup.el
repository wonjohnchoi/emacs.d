;;; backup --- backup settings
;;; Commentary:
;;; Backup settings for my Emacs.

;;; Code:
(require 'utils)
(setq backup-directory-alist
      `(("." . ,(join-paths emacs-dir "backups"))))
(setq auto-save-file-name-transforms
      `((".*" ,(join-paths emacs-dir "autosaves" "\\1") t)))
(make-directory (join-paths emacs-dir "autosaves") t)

(provide 'backup)
;;; backup.el ends here

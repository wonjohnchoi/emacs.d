;;; keys --- Key bindings
;;; Commentary:
;;; Key binding settings

;;; Code:
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-k") 'kill-line)

;; C-o M-o
(defun end-of-line-and-new-line ()
  "Move to end of file and make new line."
  (interactive)
  (end-of-line)
  (newline-and-indent))
(defun beginning-of-line-and-new-line ()
  "Move to beginning of file and make new line."
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "C-o") 'end-of-line-and-new-line)
(global-set-key (kbd "M-o") 'beginning-of-line-and-new-line)

;; iBuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Copy-Cut-Paste from clipboard with Super-C Super-X Super-V
(global-set-key (kbd "s-x") 'clipboard-kill-region) ;;cut
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save) ;;copy
(global-set-key (kbd "s-v") 'clipboard-yank) ;;paste

;; http://www.emacswiki.org/emacs/MoveLine
(defun move-line-up ()
  "Move line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; Soft tab
(setq-default indent-tabs-mode nil)

;; Delete seleted text when typing
(delete-selection-mode 1)

(provide 'keys)
;;; keys.el ends here

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

; code copied from
; http://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs
(defun move-text-internal (arg)
  "Internal used for `move-text` with ARG."
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line ARG lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line ARG lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; Soft tab
(setq-default indent-tabs-mode nil)

;; Delete seleted text when typing
(delete-selection-mode 1)

(provide 'keys)
;;; keys.el ends here

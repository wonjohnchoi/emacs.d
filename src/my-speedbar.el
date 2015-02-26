;; Speed bar
(require 'sr-speedbar)
(setq speedbar-frame-parameters
      '((minibuffer)
	(width . 20)
	(border-width . 0)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(unsplittable . t)
	(left-fringe . 0)))
(setq sr-speedbar-max-width 20)
(setq sr-speedbar-width-console 20)
(setq sr-speedbar-auto-refresh nil)
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq speedbar-update-flag nil)

;; speed bar left side
(setq sr-speedbar-right-side nil)
;; Auto refresh
(sr-speedbar-refresh-turn-off)

;; speedbar toggle
(defun my-speedbar ()
  "Toggle sr-speedbar and select."
  (interactive)
  (progn
    (sr-speedbar-toggle)
    (if (sr-speedbar-exist-p)
        (sr-speedbar-select-window))))

;; Key C-x p
(global-set-key (kbd "C-x p") 'my-speedbar)

;; Disable expand all (takes too long)
(defun speedbar-expand-line-descendants (&OPTIONAL ARG)
  "Expand &OPTIONAL ARG." ())

;; Tags
(speedbar-add-supported-extension ".js")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.js" . speedbar-parse-c-or-c++tag))
(speedbar-add-supported-extension ".py")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.py" . speedbar-parse-c-or-c++tag))

(provide 'my-speedbar)

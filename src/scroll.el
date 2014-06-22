;;; scroll --- Scroll tuning
;;; Commentary:
;;; Tuning scroll for my Emacs

;;; Code:

(setq scroll-step 1
      scroll-conservatively 10000)
(line-number-mode t)
;; Speed up
(setq redisplay-dont-pause t)
(setq jit-lock-defer-time 0.05)

(provide 'scroll)
;;; scroll.el ends here

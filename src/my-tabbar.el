;; Tabbar
(require 'tabbar)
(require 'tabbar-ruler)

(setq tabbar-ruler-global-tabbar t)
(global-set-key (kbd "C-x t") 'tabbar-ruler-move)

(tabbar-mode)
(global-set-key [C-left] 'tabbar-backward-tab)
(global-set-key [C-right] 'tabbar-forward-tab)
(global-set-key (kbd "C-x <left>") 'tabbar-backward-tab)
(global-set-key (kbd "C-x <right>") 'tabbar-forward-tab)

(provide 'my-tabbar)

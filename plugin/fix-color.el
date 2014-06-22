; fixing font-lock face for solarized
(require 'rx)
(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     '(("\\<\\([0-9]+\\(eE[+-]?[0-9]*\\)?\\|0[xX][0-9a-fA-F]+\\)\\>" . font-lock-constant-face)))))

(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     `(( ,(rx symbol-start 
                                              (or "print" "exit" )
                                              symbol-end) . font-lock-function-name-face)))))
(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     `(( ,(rx symbol-start 
                                              (or "import" "from" )
                                              symbol-end) . font-lock-preprocessor-face)))))
(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     `(( ,(rx "\\" (0+ blank) line-end ) . font-lock-preprocessor-face)))))
(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     '(( "\\(%[sdf]\\)" 1 font-lock-preprocessor-face prepend)))))
(add-hook 'python-mode-hook 
          '(lambda ()
             (font-lock-add-keywords nil
                                     '(( "\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face prepend)))))

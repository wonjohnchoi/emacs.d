;;; platforms --- Platform specific settings
;;; Commentary:
;;; Platform specific settings

;;; Code:

(require 'utils)

;; Windows
(when platform-windows?
  (progn
    ;; Key bindings
    (global-set-key (kbd "C-v") 'yank)

    ;; UTF-8
    (shell-command "chcp 65001")
    (setenv "PYTHONIOENCODING" "utf-8")

    ;; Powershell
    (load "powershell.el")
))


;; Mac OS X
(when platform-mac?
  (progn
    ;; Set command key as super
    (setq mac-command-modifier 'super)
    ;; Share Mac OS X clipboard
    (defun copy-from-osx ()
      (shell-command-to-string "pbpaste"))

    (defun paste-to-osx (text &optional push)
      (let ((process-connection-type nil))
	(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	  (process-send-string proc text)
	  (process-send-eof proc))))
    (setq interprogram-cut-function 'paste-to-osx)

    ;; Full screen
    (defun toggle-fullscreen-osx ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
    (global-set-key (kbd "M-RET") 'toggle-fullscreen-osx)

    ;; Command-arrow
    (global-set-key (kbd "<s-up>") 'beginning-of-buffer)
    (global-set-key (kbd "<s-down>") 'end-of-buffer)
    (global-set-key (kbd "<s-left>") 'beginning-of-line)
    (global-set-key (kbd "<s-right>") 'end-of-line)

    ;; Open here
    (defun open-here ()
      "Open here with X"
      (interactive)
      (shell-command "open ."))

    ;; Env variables
    (setenv "IDEVICEINSTALLER" "/usr/local/ideviceinstaller/bin/ideviceinstaller")
    (setenv "PATH" (mapconcat 'identity
			      `(,(getenv "PATH")
				"/usr/local/bin:~/Development/bin"
				"/Library/Frameworks/Python.framework/Versions/2.7/bin") path-separator))
    (mapc (lambda (x) (add-to-list 'exec-path x))
          (split-string (getenv "PATH") path-separator))))

;; Linux
(when platform-linux?

  ;; Path variable
  (setenv "PATH" (mapconcat 'identity
                            `(,(getenv "PATH")
                              ,(concat emacs-dir "/platforms/ubuntu_x64/bin")) ":"))
  (mapc (lambda (x) (add-to-list 'exec-path x)) (split-string (getenv "PATH") ":"))
  (add-hook 'after-make-frame-functions 'set-frame-menu-bar-lines)

  (global-set-key (kbd "<s-up>") 'beginning-of-buffer)
  (global-set-key (kbd "<s-down>") 'end-of-buffer)
  (global-set-key (kbd "<s-left>") 'beginning-of-line)
  (global-set-key (kbd "<s-right>") 'end-of-line)
  (global-set-key (kbd "s-k") 'kill-buffer)

  ;; Android
  (let ((android-home "/usr/local/android-sdk-linux")
	(android-ndk-home "/usr/local/android-ndk"))
    (setenv "ANDROID_HOME" android-home)
    (setenv "ANDROID_NDK_HOME" android-ndk-home)
    (setenv "PATH" (mapconcat 'identity
			      `(,(getenv "PATH")
				,(concat android-home "/tools")
				,(concat android-home "/platform-tools")
				,android-ndk-home) path-separator)))
  (mapc (lambda (x) (add-to-list 'exec-path x)) (split-string (getenv "PATH")
                                                              path-separator)))

(provide 'platforms)
;;; platforms.el ends here

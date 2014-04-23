;;; Package --- color theme
;;; Commentary:
;;; Code:
(require-package 'color-theme)
(require-package 'color-theme-molokai)

(require 'color-theme)
(color-theme-molokai)

;; {{@see http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
;; Set background color to black (color-16) when no window system
(defun set-no-window-frame-bg ()
    (when (display-graphic-p (selected-frame))
      (set-face-background 'default "black" (selected-frame))
      (set-background-color "black")))

(when window-system
  (add-hook 'window-setup-hook 'set-no-window-frame-bg))
;; }}

(provide 'init-color-theme)
;;; init-color-theme.el ends here

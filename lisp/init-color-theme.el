;;; Package --- color theme
;;; Commentary:
;;; Code:
(require-package 'color-theme)
(require-package 'color-theme-molokai)

(require 'color-theme)
(color-theme-molokai)

;; {{ Set background color
(defun init-color-theme-set-bg-color (color)
  "Set background COLOR."
  (when (not(eq color "nil"))
    (set-face-background 'default color nil)
    (set-background-color color)))

(defcustom init-color-theme-window-system-bg-color "nil"
  "Set background color when \"window-system\". If nil uses default background."
  :type '(string)
  :group 'init-color-theme
  )

(defcustom init-color-theme-no-window-system-bg-color "nil"
  "Set background color when not a \"window-system\". If nil uses default background."
  :type '(string)
  :group 'init-color-theme
  )

(init-color-theme-set-bg-color
 (if window-system
     init-color-theme-window-system-bg-color
   init-color-theme-no-window-system-bg-color))

;; }}

(provide 'init-color-theme)
;;; init-color-theme.el ends here

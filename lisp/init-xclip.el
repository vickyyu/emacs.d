;;; Package --- Configure xclip
;;; Commentary: xclip is a tool to copy/paste from/to X between terminal
;;; Code:

;; {{@see http://stackoverflow.com/questions/5288213/how-can-i-paste-the-selected-region-outside-of-emacs/14659015#14659015
;; http://www.lingotrek.com/2010/12/integrating-emacs-with-x11-clipboard-in.html
(require-package 'xclip)
(require 'xclip)

;; Prerequirements:
;; * xclip
;;   sudo apt-get install xclip

(xclip-mode 1)

(provide 'init-xclip)
;;; init-xclip.el ends here

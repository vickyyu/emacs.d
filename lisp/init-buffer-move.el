;;; Package --- Move buffer (Not move cursor)
(require-package 'buffer-move)
(require 'buffer-move)

;; buffer-move.el
(global-set-key (kbd "C-x 4 <up>")     'buf-move-up)
(global-set-key (kbd "C-x 4 <down>")   'buf-move-down)
(global-set-key (kbd "C-x 4 <left>")   'buf-move-left)
(global-set-key (kbd "C-x 4 <right>")  'buf-move-right)

(provide 'init-buffer-move)

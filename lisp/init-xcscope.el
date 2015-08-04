;;; Package --- Cscope for source code cross-reference tool
(require-package 'xcscope)
(require 'xcscope)
(cscope-setup)

;; See https://github.com/dkogan/xcscope.el
;; xcscope.el can be used as a front-end to GNU Global.
;(setq cscope-program “gtags-cscope”)

;; emacs will call C-c s I update Index will mismatch cscope -q
;(setq cscope-option-do-not-update-database "t")

;; Display the entry at point in one window.
;; (define-key cscope-list-entry-keymap [return] 'cscope-select-entry-one-window)
;; (define-key cscope-list-entry-keymap "\r" 'cscope-select-entry-one-window)

(when (executable-find "pycscope")
  (add-hook 'python-mode-hook (function cscope-minor-mode)))

(provide 'init-xcscope)

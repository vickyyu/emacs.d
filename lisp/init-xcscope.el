;;; Package --- Cscope for source code cross-reference tool
(require-package 'xcscope)
(require 'xcscope)
(cscope-setup)

;; See https://github.com/dkogan/xcscope.el
;; xcscope.el can be used as a front-end to GNU Global.
;(setq cscope-program “gtags-cscope”)

;; emacs will call C-c s I update Index will mismatch cscope -q
;(setq cscope-option-do-not-update-database "t")

;; ;; This section is used for simulation VIM shortcut
;; (defun cscope-find-this-symbol-no-prompting ()
;;   "Find a symbol without prompting."
;;   (interactive)
;;   (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
;;       (setq cscope-previous-user-search `(cscope-find-this-symbol-no-prompting ,symbol))
;;     (cscope-call "Finding symbol:" 0 symbol)
;;     ))

;; (defun cscope-find-called-functions-no-prompting ()
;;   "Display functions called a function."
;;   (interactive)
;;   (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
;;       (setq cscope-previous-user-search `( cscope-find-called-functions-no-prompting ,symbol))
;;     (cscope-call "Finding functions called by:" 2 symbol)
;;     ))

;; (defun cscope-find-functions-calling-this-function-no-prompting ()
;;   "Display functions calling a function."
;;   (interactive)
;;   (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
;;       (setq cscope-previous-user-search `( cscope-find-functions-calling-this-function-no-prompting ,symbol))
;;     (cscope-call "Finding functions calling:" 3 symbol)
;;     ))

;; (defun cscope-find-this-text-string-no-prompting ()
;;   "Locate where a text string occurs."
;;   (interactive)
;;   (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
;;       (setq cscope-previous-user-search `(cscope-find-this-text-string-no-prompting ,symbol))
;;     (cscope-call "Finding text string:" 4 symbol)
;;     ))

;; (define-key global-map "\C-\\" nil)
;; (global-set-key (kbd "C-\\ s") 'cscope-find-this-symbol-no-prompting)
;; (global-set-key (kbd "C-\\ g") 'cscope-find-global-definition-no-prompting)
;; (global-set-key (kbd "C-\\ t") 'cscope-find-this-text-string-no-prompting)
;; (global-set-key (kbd "C-\\ c") 'cscope-find-functions-calling-this-function-no-prompting)
;; (global-set-key (kbd "C-\\ C") 'cscope-find-called-functions-no-prompting)

;; Display the entry at point in one window.
;; (define-key cscope-list-entry-keymap [return] 'cscope-select-entry-one-window)
;; (define-key cscope-list-entry-keymap "\r" 'cscope-select-entry-one-window)

(when (executable-find "pycscope")
  (add-hook 'python-mode-hook (function cscope-minor-mode)))

(provide 'init-xcscope)

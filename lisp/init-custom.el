;; Turn on refresh cscope database option
;;(setq cscope-option-do-not-update-database nil)

;; Use C-u as page up key
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-page-up)

;; Use option key as meta key
(setq mac-command-modifier nil)
(setq mac-option-modifier 'meta)
;; Open new buffer with normal mode
(evil-set-initial-state 'fundamental-mode 'normal)
;; Change C-w key mapping in inster mode
(define-key evil-insert-state-map (kbd "C-w") 'evil-window-map)
;; Change C-w v mapping to open new buffer
(define-key evil-normal-state-map (kbd "C-w v") 'evil-window-vnew)

;; Modify syntax table for word syntax
(dolist (hook '(makefile-gmake-mode-hook
		makefile-bsdmake-mode-hook
		c-mode-common-hook
		conf-space-mode-hook))
  (add-hook hook
	    (lambda () (modify-syntax-entry ?_ "w"))))

;; Bind C-t with cscope-pop-mark
(define-key evil-normal-state-map (kbd "C-t") 'cscope-pop-mark)
(define-key evil-insert-state-map (kbd "C-t") 'cscope-pop-mark)

;; Support C-\ s g t c C for cscope
(defun cscope-find-this-symbol-no-prompting ()
  "Find a symbol without prompting."
  (interactive)
  (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
    (setq cscope-previous-user-search `(cscope-find-this-symbol-no-prompting ,symbol))
    (cscope-call "Finding symbol:" 0 symbol)
    ))

(defun cscope-find-called-functions-no-prompting ()
  "Display functions called a function."
  (interactive)
  (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
    (setq cscope-previous-user-search `( cscope-find-called-functions-no-prompting ,symbol))
    (cscope-call "Finding functions called by:" 2 symbol)
    ))

(defun cscope-find-functions-calling-this-function-no-prompting ()
  "Display functions calling a function."
  (interactive)
  (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
    (setq cscope-previous-user-search `( cscope-find-functions-calling-this-function-no-prompting ,symbol))
    (cscope-call "Finding functions calling:" 3 symbol)
    ))

(defun cscope-find-this-text-string-no-prompting ()
  "Locate where a text string occurs."
  (interactive)
  (let ( (symbol (cscope-extract-symbol-at-cursor nil nil)))
    (setq cscope-previous-user-search `(cscope-find-this-text-string-no-prompting ,symbol))
    (cscope-call "Finding text string:" 4 symbol)
    ))

(define-key global-map "\C-\\" nil)
(global-set-key (kbd "C-\\ s") 'cscope-find-this-symbol-no-prompting)
(global-set-key (kbd "C-\\ g") 'cscope-find-global-definition-no-prompting)
(global-set-key (kbd "C-\\ t") 'cscope-find-this-text-string-no-prompting)
(global-set-key (kbd "C-\\ c") 'cscope-find-functions-calling-this-function-no-prompting)
(global-set-key (kbd "C-\\ C") 'cscope-find-called-functions-no-prompting)

; Close window when select a entry for cscope
(define-key cscope-list-entry-keymap [return] 'cscope-select-entry-one-window)
(define-key cscope-list-entry-keymap "\r" 'cscope-select-entry-one-window)

(provide 'init-custom)


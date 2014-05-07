;; load undo-tree and ert
(require-package 'evil)
(require 'evil)

(add-to-list 'load-path "~/.emacs.d/site-lisp/evil/lib")
(evil-mode 1)

;; {{@see https://github.com/timcharper/evil-surround
(require-package 'surround)
(require 'surround)

(global-surround-mode 1)
;; }}

;; {{@see http://dnquark.com/blog/2012/02/emacs-evil-ecumenicalism/
;; Make insert mode with unadulterated Emacs behavior
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map
  (read-kbd-macro evil-toggle-key) 'evil-emacs-state)
;; }}

(defun toggle-org-or-message-mode ()
  (interactive)
  (if (eq major-mode 'message-mode)
    (org-mode)
    (if (eq major-mode 'org-mode) (message-mode))
    ))

;; (evil-set-initial-state 'org-mode 'emacs)
;; Remap org-mode meta keys for convenience
(evil-declare-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "gl" 'outline-next-visible-heading
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    (kbd "TAB") 'org-cycle
    )

(loop for (mode . state) in
      '(
        (minibuffer-inactive-mode . emacs)
        (Info-mode . emacs)
        (term-mode . emacs)
        (sdcv-mode . emacs)
        (log-edit-mode . emacs)
        (inf-ruby-mode . emacs)
        (direx:direx-mode . emacs)
        (yari-mode . emacs)
        (erc-mode . emacs)
        (gud-mode . emacs)
        (help-mode . emacs)
        (eshell-mode . emacs)
        (shell-mode . emacs)
        ;;(message-mode . emacs)
        (magit-log-edit-mode . emacs)
        (fundamental-mode . emacs)
        (gtags-select-mode . emacs)
        (weibo-timeline-mode . emacs)
        (weibo-post-mode . emacs)
        (sr-mode . emacs)
        (dired-mode . emacs)
        (compilation-mode . emacs)
        (speedbar-mode . emacs)
        (magit-commit-mode . normal)
        (js2-error-buffer-mode . emacs)
	(cscope-list-entry-mode . normal)
        (fundamental-mode . normal)
        )
      do (evil-set-initial-state mode state))

;; When Evil initiailizing (evil-initialize-state), 'evil-change-to-initial-state'
;; will be called. But some modes still need to call 'evil-change-to-initial-state'
;; when hooking to mode
(loop for (hook) in
      '(
	(cscope-list-entry-hook)
	)
      do (add-hook hook 'evil-change-to-initial-state))

(define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
(define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)

(define-key evil-normal-state-map "Y" (kbd "y$"))
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map "go" 'goto-char)

(require-package 'evil-matchit)
(require 'evil-matchit)

(global-evil-matchit-mode 1)

(eval-after-load "evil" '(setq expand-region-contract-fast-key "z"))

;; @see http://stackoverflow.com/questions/10569165/how-to-map-jj-to-esc-in-emacs-evil-mode
;; @see http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
(define-key evil-insert-state-map "k" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "k")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

;; Window commands
(define-key evil-window-map [left]  'evil-window-left)
(define-key evil-window-map [down]  'evil-window-down)
(define-key evil-window-map [up]    'evil-window-up)
(define-key evil-window-map [right] 'evil-window-right)

;; If evil-want-C-w-delete is t, C-w as delete at normal/visual mode
(defun evil-want-C-w-delete-in-state (keymap)
  "If evil-want-C-w-delete is t, C-w as delete in state-map"
  (when evil-want-C-w-delete
    (define-key keymap (kbd "C-w") 'evil-delete)))

(add-hook 'after-init-hook
	  (lambda ()
	    (evil-want-C-w-delete-in-state evil-normal-state-map)
	    (evil-want-C-w-delete-in-state evil-visual-state-map)))

(global-set-key (kbd "M-:") 'evil-ex)

;; Leave return (ENTER) key for local key-map
;; It is used for magit-log, cscope, etc. mode.
(define-key evil-motion-state-map (kbd "RET") nil)
(define-key evil-insert-state-map (kbd "M-a") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "M-e") 'move-end-of-line)
(define-key evil-normal-state-map (kbd "C-y") 'yank)
(define-key evil-visual-state-map (kbd "C-y") 'yank)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)
(define-key evil-normal-state-map (kbd "C-d") 'evil-delete-char)
(define-key evil-visual-state-map (kbd "C-d") 'evil-delete-char)
(define-key evil-insert-state-map (kbd "M-k") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "M-k") 'evil-exit-visual-state)
(define-key minibuffer-local-map (kbd "M-k") 'abort-recursive-edit)
(define-key evil-insert-state-map (kbd "M-j") 'my-yas-expand)
(global-set-key (kbd "M-k") 'keyboard-quit)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-page-up)

(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; {{ evil-leader config
(require-package 'evil-leader)
(require 'evil-leader)

(global-evil-leader-mode 1)

(setq evil-leader/leader ",")

(defun evilcvn--change-symbol(fn)
  (let ((old (thing-at-point 'symbol)))
    (funcall fn)
    (unless (evil-visual-state-p)
      (kill-new old)
      (evil-visual-state))
    (evil-ex (concat "'<,'>s/" (if (= 0 (length old)) "" "\\<\\(") old (if (= 0 (length old)) "" "\\)\\>/"))))
  )

(defun evilcvn-change-symbol-in-whole-buffer()
  "mark the region in whole buffer and use string replacing UI in evil-mode
to replace the symbol under cursor"
  (interactive)
  (evilcvn--change-symbol 'mark-whole-buffer)
  )

(defun evilcvn-change-symbol-in-defun ()
  "mark the region in defun (definition of function) and use string replacing UI in evil-mode
to replace the symbol under cursor"
  (interactive)
  (evilcvn--change-symbol 'mark-defun)
  )

(evil-leader/set-key
  "as" 'ack-same
  "ac" 'ack
  "aa" 'ack-find-same-file
  "af" 'ack-find-file
  "bf" 'beginning-of-defun
  "ef" 'end-of-defun
  "db" 'sdcv-search-pointer ;; in another buffer
  "dt" 'sdcv-search-input+ ;; in tip
  "mf" 'mark-defun
  "em" 'erase-message-buffer
  "eb" 'eval-buffer
  "ee" 'eval-expression
  "cx" 'copy-to-x-clipboard
  "cy" 'strip-convert-lines-into-one-big-string
  "cff" 'current-font-face
  "fn" 'copy-filename-of-current-buffer
  "fp" 'copy-full-path-of-current-buffer
  "dj" 'dired-jump ;; open the dired from current file
  "ff" 'toggle-full-window ;; I use WIN+F in i3
  "gt" 'get-term
  "px" 'paste-from-x-clipboard
  ;; "ci" 'evilnc-comment-or-uncomment-lines
  ;; "cl" 'evilnc-comment-or-uncomment-to-the-line
  ;; "cc" 'evilnc-copy-and-comment-lines
  ;; "cp" 'evilnc-comment-or-uncomment-paragraphs
  "ct" 'ctags-create-or-update-tags-table
  "cd" 'evilcvn-change-symbol-in-defun
  "cb" 'evilcvn-change-symbol-in-whole-buffer
  "tt" 'ido-goto-symbol ;; same as my vim hotkey
  "cg" 'helm-ls-git-ls
  "ud" '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer))))
  "W" 'save-some-buffers
  "K" 'kill-buffer-and-window ;; "k" is preserved to replace "C-g"
  "it" 'issue-tracker-increment-issue-id-under-cursor
  "hh" 'highlight-symbol-at-point
  "hn" 'highlight-symbol-next
  "hp" 'highlight-symbol-prev
  "hq" 'highlight-symbol-query-replace
  "bm" 'pomodoro-start ;; beat myself
  "im" 'helm-imenu
  "." 'evil-ex
  ;; toggle overview,  @see http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
  "oo" 'switch-window
  "ov" '(lambda () (interactive) (set-selective-display (if selective-display nil 1)))
  "or" 'open-readme-in-git-root-directory
  "mq" '(lambda () (interactive) (man (concat "-k " (thing-at-point 'symbol))))
  "gg" '(lambda () (interactive) (w3m-search "g" (thing-at-point 'symbol)))
  "qq" '(lambda () (interactive) (w3m-search "q" (thing-at-point 'symbol)))
  "hr" 'helm-recentf
  "jb" 'js-beautify
  "se" 'string-edit-at-point
  "s0" 'delete-window
  "s1" 'delete-other-windows
  "s2" '(lambda () (interactive) (if *emacs23* (split-window-vertically) (split-window-right)))
  "s3" '(lambda () (interactive) (if *emacs23* (split-window-horizontally) (split-window-below)))
  "su" 'winner-undo
  "x0" 'delete-window
  "x1" 'delete-other-windows
  "x2" '(lambda () (interactive) (if *emacs23* (split-window-vertically) (split-window-right)))
  "x3" '(lambda () (interactive) (if *emacs23* (split-window-horizontally) (split-window-below)))
  "xu" 'winner-undo
  "to" 'toggle-web-js-offset
  "sl" 'sort-lines
  "ur" 'uniquify-all-lines-region
  "ub" 'uniquify-all-lines-buffer
  "ls" 'package-list-packages
  "lo" 'moz-console-log-var
  "lj" 'moz-load-js-file-and-send-it
  "rr" 'moz-console-clear
  "ws" 'w3mext-hacker-search
  "hs" 'helm-swoop
  "hd" 'describe-function
  "hf" 'find-function
  "hv" 'describe-variable
  "hb" 'helm-back-to-last-point
  "gf" 'gtags-find-tag-from-here
  "gp" 'gtags-pop-stack
  "gr" 'gtags-find-rtag
  "gy" 'gtags-find-symbol
  "gl" 'magit-log
  "gst" 'magit-status
  "fb" 'flyspell-buffer
  "fe" 'flyspell-goto-next-error
  "fa" 'flyspell-auto-correct-word
  "fw" 'ispell-word
  "dg" 'djcb-gtags-create-or-update
  "bc" '(lambda () (interactive) (wxhelp-browse-class-or-api (thing-at-point 'symbol)))
  "ma" 'mc/mark-all-like-this-in-defun
  "mw" 'mc/mark-all-words-like-this-in-defun
  "ms" 'mc/mark-all-symbols-like-this-in-defun
  ;; recommended in html
  "md" 'mc/mark-all-like-this-dwim
  "rw" 'rotate-windows
  "oc" 'occur
  "om" 'toggle-org-or-message-mode
  "ops" 'my-org2blog-post-subtree
  "ut" 'undo-tree-visualize
  "al" 'align-regexp
  "ww" 'save-buffer
  "bk" 'buf-move-up
  "bj" 'buf-move-down
  "bh" 'buf-move-left
  "bl" 'buf-move-right
  "0" 'select-window-0
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5
  "6" 'select-window-6
  "7" 'select-window-7
  "8" 'select-window-8
  "9" 'select-window-9
  "xm" 'smex
  "xx" 'er/expand-region
  "xf" 'ido-find-file
  "xb" 'ido-switch-buffer
  "xc" 'save-buffers-kill-terminal
  "xo" 'helm-find-files
  "vd" 'scroll-other-window
  "vu" '(lambda () (interactive) (scroll-other-window-down nil))
  "js" 'w3mext-search-js-api-mdn
  "je" 'js2-display-error-list
  "te" 'js2-mode-toggle-element
  "tf" 'js2-mode-toggle-hide-functions
  "xh" 'mark-whole-buffer
  "xk" 'ido-kill-buffer
  "xs" 'save-buffer
  "xz" 'suspend-frame
  "xvv" 'vc-next-action
  "xva" 'git-add-current-file
  "xrf" 'git-reset-current-file
  "xvu" 'git-add-option-update
  "xvg" 'vc-annotate
  "xv=" 'git-gutter:popup-hunk
  "ps" 'my-goto-previous-section
  "ns" 'my-goto-next-section
  "pp" 'my-goto-previous-hunk
  "nn" 'my-goto-next-hunk
  "xvs" 'git-gutter:stage-hunk
  "xvr" 'git-gutter:revert-hunk
  "xvl" 'vc-print-log
  "xvp" 'git-messenger:popup-message
  "xnn" 'narrow-to-region
  "xnw" 'widen
  "xnd" 'narrow-to-defun
  "xnr" 'narrow-to-region
  "xw" 'widen
  "xd" 'narrow-to-defun
  "zc" 'wg-create-workgroup
  "zk" 'wg-kill-workgroup
  "zv" 'wg-switch-to-workgroup
  "zj" 'wg-switch-to-workgroup-at-index
  "z0" 'wg-switch-to-workgroup-at-index-0
  "z1" 'wg-switch-to-workgroup-at-index-1
  "z2" 'wg-switch-to-workgroup-at-index-2
  "z3" 'wg-switch-to-workgroup-at-index-3
  "z4" 'wg-switch-to-workgroup-at-index-4
  "z5" 'wg-switch-to-workgroup-at-index-5
  "z6" 'wg-switch-to-workgroup-at-index-6
  "z7" 'wg-switch-to-workgroup-at-index-7
  "z8" 'wg-switch-to-workgroup-at-index-8
  "z9" 'wg-switch-to-workgroup-at-index-9
  "zs" 'wg-save-session
  "zb" 'wg-switch-to-buffer
  "zp" 'wg-switch-to-workgroup-left
  "zn" 'wg-switch-to-workgroup-right
  "zwu" 'wg-undo-wconfig-change
  "zwr" 'wg-redo-wconfig-change
  "zws" 'wg-save-wconfig
  )
;; }}

;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                 ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                                 (t default-color))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))))))

;; comment/uncomment lines
(require-package 'evil-nerd-commenter)
(require 'evil-nerd-commenter)

(evilnc-default-hotkeys)

(provide 'init-evil)

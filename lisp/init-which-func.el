;;; Package --- Configure which-func.el
;;; Commentary: To show the function name which you are navigating
;;; Code:

;; {{@see http://emacsredux.com/blog/2014/04/05/which-function-mode/
(require 'which-func)

;; Enable which function mode which supported
(which-function-mode)

(custom-set-variables
 '(which-func-modes
   '(emacs-lisp-mode
     c-mode
     c++-mode
     objc-mode
     perl-mode
     cperl-mode
     python-mode
     makefile-mode
     sh-mode
     fortran-mode f90-mode
     ada-mode
     diff-mode)))

;; string that shows when not in function
(setq which-func-unknown "n/a")

;; ;; Show the current function name in the header line
;; (setq-default header-line-format
;;	      '((which-func-mode ("" which-func-format " "))))
;; (setq mode-line-misc-info
;;       ;; We remove Which Function Mode from the mode line, because it's mostly
;;       ;; invisible here anyway.
;;       (assq-delete-all 'which-func-mode mode-line-misc-info))

(provide 'init-which-func)
;;; init-which-func.el ends here

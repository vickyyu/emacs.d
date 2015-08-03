;;; Package --- Configure JEDI
;;; Commentary: Jedi.el is a Python auto-completion package for Emacs.
;;; Code:

;; {{@see https://github.com/tkf/emacs-jedi
(require-package 'jedi)
(require 'jedi)

;; Prerequirements:
;; * Command line program
;;   virtualenv ([sudo] pip install virtualenv)

(unless (executable-find "virtualenv")
      (message "vairtualenv could not be found!!!!")
      (message "Installation: [sudo] pip install virtualenv"))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Type:
;;     M-x jedi:install-server RET
;; Then open Python file.

;; Tree style source code viewer for Python buffer
(require-package 'direx)
(require-package 'jedi-direx)

(eval-after-load "python"
  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)

(provide 'init-jedi)
;;; init-jedi.el ends here

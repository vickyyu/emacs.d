(require 'python)
(setq python-shell-interpreter "ipython")
;; (setq python-shell-interpreter-args "--pylab")

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))


(provide 'init-python-mode)

;;; json-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (json-mode json-mode-beautify-ordered json-mode-beautify)
;;;;;;  "json-mode" "json-mode.el" (21271 8418 166701 874000))
;;; Generated autoloads from json-mode.el

(autoload 'json-mode-beautify "json-mode" "\
Beautify / pretty-print from BEG to END, and optionally PRESERVE-KEY-ORDER.

\(fn &optional PRESERVE-KEY-ORDER)" t nil)

(autoload 'json-mode-beautify-ordered "json-mode" "\
Beautify / pretty-print from BEG to END preserving key order.

\(fn)" t nil)

(autoload 'json-mode "json-mode" "\
Major mode for editing JSON files

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;;;***

;;;### (autoloads nil nil ("json-mode-pkg.el") (21271 8418 243150
;;;;;;  146000))

;;;***

(provide 'json-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; json-mode-autoloads.el ends here

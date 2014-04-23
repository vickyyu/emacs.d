;;; tidy-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (tidy-buffer tidy-save-settings tidy-parse-config-file
;;;;;;  tidy-build-menu) "tidy" "tidy.el" (21271 8433 866779 723000))
;;; Generated autoloads from tidy.el

(autoload 'tidy-build-menu "tidy" "\
Set up the tidy menu in MAP. Used to set up a Tidy menu in your
favourite mode.

\(fn &optional MAP)" t nil)

(autoload 'tidy-parse-config-file "tidy" "\
If `tidy-config-file' is non-nil parse that file setting variables accordingly.

\(fn)" t nil)

(autoload 'tidy-save-settings "tidy" "\
Query saving the current settings to your `tidy-config-file'.
Perhaps put this on your `kill-buffer-hook'.

\(fn &optional CONFIG-FILE)" t nil)

(autoload 'tidy-buffer "tidy" "\
Run the HTML Tidy program on the current buffer.
If PREFIX is non-nil, or if called interactively with a prefix argument,
then Tidy is applied to the currently selected region.  Any error messages
generated by that program are sent to \"*tidy-errors*\" buffer.

\(fn &optional PREFIX)" t nil)

;;;***

;;;### (autoloads nil nil ("tidy-pkg.el") (21271 8433 946802 169000))

;;;***

(provide 'tidy-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tidy-autoloads.el ends here

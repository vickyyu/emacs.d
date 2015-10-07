;;; Package --- Configure key chord package
;;; Commentary:
;;; Map pairs of simultaneously pressed keys to commands
;;; Code:
(require-package 'key-chord)
(require 'key-chord)

(key-chord-mode 1)

(when (maybe-require-package 'avy)
  (autoload 'avy-goto-word-or-subword-1 "avy")
  (key-chord-define-global "jj" 'avy-goto-word-or-subword-1)
  (key-chord-define-global "j'" 'avy-pop-mark))

(when (maybe-require-package 'evil)
  (when (boundp 'evil-insert-state-map)
    (key-chord-define-global ",," 'evil-execute-in-normal-state)))

(provide 'init-key-chord)
;;; init-key-chord.el ends here

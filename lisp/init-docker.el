;;; Package --- Configure docker
;;; Commentary:
;;; Code:
;; {{@see
;; https://github.com/spotify/dockerfile-mode
;; }}
(require-package 'dockerfile-mode)

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(provide 'init-docker)
;;; init-docker.el ends here

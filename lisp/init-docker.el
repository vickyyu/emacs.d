;;; Package --- Configure docker
;;; Commentary:
;;; Code:
;; {{@see
;; https://github.com/spotify/dockerfile-mode
;; }}

(require-package 'dockerfile-mode)

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))



;; @See https://github.com/Silex/docker.el
(require-package 'docker)

;; The default keymap prefix is 'C-c d'
(docker-global-mode 1)

(provide 'init-docker)
;;; init-docker.el ends here

;;; Package --- Expect with elisp
;;; Commentary:
;;; Code:
(defvar expect-process nil)

(defun get-current-buffer-process ()
  "Get PROCESS from current buffer and set to variable expect-process."
  (setq expect-process (get-process (get-buffer-process (current-buffer)))))

(defun expect-send (string)
  "Send STRING to the current buffer's process.
A newline will be appended to the string before sending."
  (when (not(eq 'get-current-buffer-process nil))
    (process-send-string expect-process (concat string "\n"))))

(defun expect-send-string (string)
  "Send STRING to the current buffer's process."
  (when (not(eq 'get-current-buffer-process nil))
    (process-send-string expect-process string)))

(defun expect-send-string-list (strlist)
  "Send STRLIST to the current buffer's process."
  (mapc 'expect-send-string strlist))

(defun ee-get-dsp-test ()
  "Use tftp to get dsp_test from 10.20.60.118."
  (interactive)
  (expect-send-string-list (list
			    "cd /tmp\n"
			    "tftp -g -r dsp_test 10.20.60.118\n")))

(defun ee-tftp-get-file (file server)
  "Use tftp to get FILE form SERVER and put into tmp."
  (interactive "sFile name: \nsServer: ")
  (expect-send-string-list (list
			    "cd /tmp\n"
			    (concat "tftp -g -r " file " " server "\n"))))

(defun ee-tftp-get-fvphone (postfix server)
  "Use tftp to get fvphone form SERVER and put into tmp."
  (interactive "sPostfix: \nsServer: ")
  (expect-send-string-list (list
			    "cd /tmp\n"
			    (concat "tftp -g -r fvphone" postfix " " server " -l fvphone\n")
			    "chmod 777 fvphone\n"
			    "/etc/init.d/evoip.sh restart\n")))

(defun ee-get-ipo21-fvphone-2510 ()
  "Use tftp to get fvphone form SERVER and put into tmp."
  (interactive)
  (expect-send-string-list (list
			    "/etc/init.d/evoip.sh stop\n"
			    "cd /tmp\n"
			    "tftp -g -r fvphone_2510 -l fvphone 10.20.0.21\n"
			    "chmod 777 fvphone\n"
			    "/etc/init.d/evoip.sh start\n")))


(provide 'init-eexpect)
;;; init-eexpect.el ends here

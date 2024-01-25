;;; liquid-mode.el --- Q

(defgroup liquid-mode nil
  "Run code blocks in buffer."
  :prefix "liquid-mode-"
  :group 'languages)

(defcustom liquid-mode-command "silq"
  "The system command to run the code block."
  :type 'string
  :group 'liquid-mode)

(defun liquid-mode-extract-code ()
  "Extract code blocks from the current buffer."
  (save-excursion
    (goto-char (point-min))
    (let ((code-blocks '()))
      (while (search-forward-regexp "```.*\n\\(.*?\\)```" nil t)
        (let ((code (match-string 1)))
          (setq code-blocks (append code-blocks (list code)))))
      (mapconcat 'identity code-blocks "\n"))))

(defun liquid-mode-run-code (code)
  "Run the given CODE string with `liquid-mode-command'."
  (let ((output (shell-command-to-string (concat liquid-mode-command " -c '" code "'"))))
    (message "OK. Output: %s" output)))

(defun liquid-mode-process-buffer ()
  "Process the current buffer, run code blocks and display results."
  (interactive)
  (let ((code (liquid-mode-extract-code)))
    (when code
      (liquid-mode-run-code code))))

(define-derived-mode liquid-mode fundamental-mode "Liquid"
  "Major mode for running code blocks."
  (define-key liquid-mode-map (kbd "C-c C-c") 'liquid-mode-process-buffer))

(provide 'liquid-mode)


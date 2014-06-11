;; Add el-get to load-path

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; Jedi (auto-completion extension)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Linum

(global-linum-mode t)
(setq linum-format "%2d\u2502 ")

;; Set default column width to 80

(setq-default fill-column 80)

;; Set auto-fill-mode to on

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Key Bindings

(global-set-key (kbd "C-x TAB") 'indent-rigidly)

;; Show file path in frame bar

(setq frame-title-format '((:eval default-directory)))

;; Share the Mac clipboard with emacs

(defun copy-from-osx ()
(shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
(let ((process-connection-type nil)) 
(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
(process-send-string proc text)
(process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

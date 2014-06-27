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

;; Line numbering

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

;; True copy/paste from clipboard

(defun pt-pbpaste ()
  "Paste data from pasteboard."
  (interactive)
  (shell-command-on-region
   (point)
   (if mark-active (mark) (point))
   "pbpaste" nil t))

(defun pt-pbcopy ()
  "Copy region to pasteboard."
  (interactive)
  (print (mark))
  (when mark-active
    (shell-command-on-region
     (point) (mark) "pbcopy")
    (kill-buffer "*Shell Command Output*")))

(global-set-key [?\C-x ?\C-y] 'pt-pbpaste)
(global-set-key [?\C-x ?\M-w] 'pt-pbcopy) 

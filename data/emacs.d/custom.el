(setq user-full-name "Honglin Yu")
(setq user-mail-address "honglin.yu@anu.edu.au")

(cond
 ((string-equal (system-name) "RSFAS-22673")
  (setq home-directory "/Users/honglinyu/"))
 ((string-equal (system-name) "lin-ThinkPad-W530")
  (setq home-directory "/home/lin/")))

(load-theme 'tango-dark)

;; path (src:http://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable)
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

(setq inhibit-startup-message t)

(toggle-scroll-bar -1)
(tool-bar-mode -1)

(column-number-mode)

(require 'recentf)
(recentf-mode 1)

(setq comint-prompt-read-only nil)
;; multi-shell
(if (not (version< emacs-version "25"))
    (add-to-list 'display-buffer-alist
     '("^\\*shell\\*$" . (display-buffer-same-window))))
(setq shellnumber 0)
(defun newshell () (interactive) (progn 
                                          (shell)
                                          (rename-buffer (concat (number-to-string shellnumber) "shell"))
                                          (setq shellnumber (+ shellnumber 1))
                                          ))
(global-set-key "\C-x." 'newshell)
(add-hook 'shell-mode-hook 
          '(lambda () (toggle-truncate-lines 1)))

(setq x-select-enable-clipboard t)

(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; automatically close the *Completion* buffer
; for file openning
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))
; for shell completion
(defun delete-completion-window-buffer (&optional output)
  (interactive)                                                                                                
  (dolist (win (window-list))                                                                                  
    (when (string= (buffer-name (window-buffer win)) "*Completions*")                                          
      (delete-window win)                                                                                      
      (kill-buffer "*Completions*")))                                                                          
  output)                                                                                                      
(add-hook 'comint-preoutput-filter-functions 'delete-completion-window-buffer)

;; full screen
(global-set-key [f11] 'my-fullscreen)
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )

;; window movements
(global-set-key (kbd "C-M-p") 'windmove-up)
(global-set-key (kbd "C-M-b") 'windmove-left)
(global-set-key (kbd "C-M-n") 'windmove-down)
(global-set-key (kbd "C-M-f") 'windmove-right)

;; shrink and enlarge window
(global-set-key (kbd "M-,") 'shrink-window)
(global-set-key (kbd "M-.") 'enlarge-window)

; open current folder with nautilus
(defun open-folder-with-xdg ()
 "open current folder with nautilus"
 (interactive)
 (shell-command (concat "nautilus " (file-name-as-directory "."))))
(global-set-key (kbd "C-c i") 'open-folder-with-xdg)

; open current folder with gnome-terminal
(defun open-folder-with-terminal ()
 "open current folder with nautilus"
 (interactive)
 (shell-command (concat "gnome-terminal --working-directory " default-directory)))
(global-set-key (kbd "C-c t") 'open-folder-with-terminal)


;; global key map                                                               
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c t") 'open-folder-with-terminal)
    (define-key map "\C-x." 'newshell)
    (define-key map [f11] 'my-fullscreen)
    ;; window movements                                                         
    (define-key map (kbd "C-M-p") 'windmove-up)
    (define-key map (kbd "C-M-b") 'windmove-left)
    (define-key map (kbd "C-M-n") 'windmove-down)
    (define-key map (kbd "C-M-f") 'windmove-right)
    ;; shrink and enlarge window                                                
    (define-key map (kbd "M-,") 'shrink-window)
    (define-key map (kbd "M-.") 'enlarge-window)
    ;; open current folder with nautilus                                        
    (define-key map (kbd "C-c i") 'open-folder-with-xdg)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

;; auto reload pdf files
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

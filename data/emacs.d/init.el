(load-file "~/.emacs.d/custom.el")

(add-to-list 'load-path "~/.emacs.d/use-package/")
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")))

(package-initialize)

(use-package cmake-mode
  :ensure t)

(use-package flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  :ensure t)

(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  :ensure t)

(use-package tex-site
  :ensure auctex)

(use-package magit
  :ensure t)

(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/"))
  :bind
  (
   :map yas-minor-mode-map
   ("C-c C-y" . yas-expand))
  :ensure t)

(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "C-x f") 'helm-recentf)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-autoresize-mode)
  (setq helm-autoresize-min-height 10
	helm-autoresize-max-height 20)
  :ensure t)

(use-package ess
  :config
  (setq inferior-R-args "--no-restore-history --no-save")
  (require 'ess-jags-d)
  :ensure t)

(use-package selected
  :ensure t
  :commands selected-minor-mode
  :bind (:map selected-keymap
              ("q" . selected-off)
              ("u" . upcase-region)
              ("d" . downcase-region)
              ("w" . count-words-region)
              ("m" . apply-macro-to-region-lines)))

(use-package elpy
  :config
  (elpy-enable)
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package clang-format
  :config
  (add-hook 'c++-mode-hook '(lambda ()
			      (local-set-key (kbd "C-c C-c") 'clang-format)))
;;  (if (string-equal system-type "darwin")
;;      (setq clang-format-executable "/opt/local/libexec/llvm-3.7/bin/clang-format"))
  :ensure t)

(use-package request
  :ensure t)

(use-package org
  :ensure t
  :config
  (setq org-hide-emphasis-markers t)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-bullets
  :ensure t)

(use-package s
  :ensure t)

(put 'upcase-region 'disabled nil)

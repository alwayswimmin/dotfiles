(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-collection company-ycmd ycmd which-key ycm org-contacts org-bullets org-evil use-package helm evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package lispy
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (defun conditionally-enable-lispy ()
    (when (eq this-command 'eval-expression)
      (lispy-mode 1)))
  (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy))

(use-package helm
  :ensure t
  :config
  (helm-mode 1))

(use-package org
  :ensure org-plus-contrib
  :bind(("C-c l" . org-store-link)
	("C-c a" . org-agenda)
	("C-c c" . org-capture)
	("C-c b" . org-switchb))
  :config
  (setq org-log-done t)
  (use-package org-evil
    :ensure t)
  (use-package org-bullets
    :ensure t
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    (setq org-bullets-bullet-list '("•")))
  (setq org-agenda-files (list "~/org"))
  (add-hook 'org-mode-hook #'toggle-word-wrap)
  (require 'org-contacts))

(use-package solarized-theme
  :preface
  (setq solarized-use-variable-pitch nil)
  (setq solarized-scale-org-headlines nil)
  (setq solarized-height-minus-1 1)
  (setq solarized-height-plus-1 1)
  (setq solarized-height-plus-2 1)
  (setq solarized-height-plus-3 1)
  (setq solarized-height-plus-4 1)
  :ensure t
  :config
  (load-theme 'solarized-light t))

(use-package ycmd
  :ensure t
  :config
  (set-variable 'ycmd-server-command '("python" "/Users/shsiang/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/"))
  (add-hook 'after-init-hook #'global-ycmd-mode)
  (use-package company-ycmd
    :ensure t
    :config
    (company-ycmd-setup)
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

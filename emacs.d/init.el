(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  ;; (add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  )

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
  (setq org-agenda-files (directory-files-recursively "~/org" "org$"))
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
  (if (string-suffix-p "Light" (getenv "ITERM_PROFILE")) (load-theme 'solarized-light t) (load-theme 'solarized-dark t))
  (custom-set-faces (if (not window-system) '(default ((t (:background "nil")))))))

(use-package ycmd
  :ensure t
  :config
  (set-variable 'ycmd-server-command `("python3" ,(file-truename "~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/")))
  (set-variable 'ycmd-extra-conf-whitelist '("~/*"))
  (add-hook 'after-init-hook #'global-ycmd-mode)
  (use-package company-ycmd
    :ensure t
    :config
    (setq company-dabbrev-downcase 0)
    (setq company-idle-delay 0)
    (company-tng-configure-default)
    (company-ycmd-setup)
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package clang-format
  :ensure t
  :config
  (global-set-key (kbd "C-c i") 'clang-format-region)
  (global-set-key (kbd "C-c u") 'clang-format-buffer))

(use-package powerline
  :ensure t
  :config
  (powerline-center-evil-theme))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package protobuf-mode
  :ensure t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq-default fill-column 80)

(global-display-line-numbers-mode)

(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline t)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(protobuf-mode powerline clang-format which-key company-ycmd ycmd solarized-theme org-bullets org-evil org-plus-contrib helm lispy evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "nil")))))

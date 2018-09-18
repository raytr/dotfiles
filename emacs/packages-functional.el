;; For packages that actually add functionality
(require 'use-package)
(use-package ranger
  :ensure t
  :commands (ranger)
  :init
  (ranger-override-dired-mode t))

(use-package magit
  :ensure t)
;; Give the ability to swap buffers around
(use-package buffer-move
  :ensure t)
;; Ivy search box/filler thing
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (counsel-mode 1))
;; Vim keybinds
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; Adds more Ex commands to evil mode
(use-package evil-expat
  :ensure t
  ;; optional, defer loading until 1 second of inactivity,
  ;; hence not affecting emacs startup time
  :defer 1)

;; Make the ESC key work everywhere
(use-package evil-escape
  :after evil
  :ensure t
  :config
  (evil-escape-mode 1)
  (global-set-key (kbd "ESC") 'evil-escape))


;; Even more evil binds
(use-package evil-collection
  :after (evil ivy)
  :ensure t
  :init
  ;;(setq evil-collection-setup-minibuffer t)
  (evil-collection-init))
;; Evil binds for magit
(use-package evil-magit
  :after magit
  :ensure t
  :config
  (require 'evil-magit))

;; Adds evil binds to org mode
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


;; Quickly add comments to file
(use-package evil-nerd-commenter
  :ensure t)

;; Manages keybinds
(use-package general
  :after evil-collection
  :ensure t)

;; Distraction-free writing mode
(use-package olivetti
  :ensure t)


(defun essay/toggle-writing-mode ()
  "Toggle a distraction-free environment for writing."
  (interactive)
  (cond ((bound-and-true-p olivetti-mode)
	 (linum-relative-global-mode 1)
	 (olivetti-mode -1))
	(t
	 (linum-relative-global-mode -1)
	 (olivetti-set-width 100)
	 (olivetti-mode 1))))

(use-package latex-preview-pane
  :ensure t
  :config
  (latex-preview-pane-enable))

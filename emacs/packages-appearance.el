;; For packages that don't do anything except alter the appearance
(require 'use-package)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tomorrow-night t))

(use-package linum-relative
  :ensure t
  :config
  ;;(setq linum-relative-current-symbol "")
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode))


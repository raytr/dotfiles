(require 'general)

;; * Mode Keybindings
(evil-define-motion move-7-lines-down ()
  (evil-next-visual-line 7))

(evil-define-motion move-7-lines-up ()
  (evil-previous-visual-line 7))

(defvar my-skippable-buffers '("*Buffer List*" "*Ibuffer*" "*scratch*" "*Messages*" "*Help*")
  "Buffer names ignored by `my-next-buffer' and `my-previous-buffer'.")

(defun my-change-buffer (change-buffer)
  "Call CHANGE-BUFFER until current buffer is not in `my-skippable-buffers'."
  (let ((initial (current-buffer)))
    (funcall change-buffer)
    (let ((first-change (current-buffer)))
      (catch 'loop
	(while (member (buffer-name) my-skippable-buffers)
	  (funcall change-buffer)
	  (when (eq (current-buffer) first-change)
	    (switch-to-buffer initial)
	    (throw 'loop t)))))))

(defun my-next-buffer ()
  "Variant of `next-buffer' that skips `my-skippable-buffers'."
  (interactive)
  (my-change-buffer 'evil-next-buffer))

(defun my-previous-buffer ()
  "Variant of `previous-buffer' that skips `my-skippable-buffers'."
  (interactive)
  (my-change-buffer 'evil-prev-buffer))

;; Binds that work everywhere
(general-define-key
 :keymaps 'override
 "M-L" 'buf-move-right
 "M-K" 'buf-move-up
 "M-J" 'buf-move-down
 "M-H" 'buf-move-left
 "M-j" 'evil-window-down
 "M-k" 'evil-window-up
 "M-h" 'evil-window-left
 "M-l" 'evil-window-right
 "M-v" 'evil-window-vsplit
 "M-c" 'evil-window-split
 "M-q" 'evil-window-delete
 "C-l" 'my-next-buffer
 "C-h" 'my-previous-buffer)

;; Binds that only work when not in insert mode
(general-define-key
 :states '(normal visual)
 :keymaps 'override
 "!" 'evilnc-comment-or-uncomment-lines
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line
 "J" 'move-7-lines-down
 "K" 'move-7-lines-up)

;; Leader key <SPACE>
(general-create-definer my-leader-def
  :prefix "SPC")
;; Leader binds
(my-leader-def
  :states '(normal visual)
  :keymaps 'override
  "b" 'ibuffer
  "r" 'ranger
  "m" 'magit-status
  "f" 'swiper
  "o" 'ivy-switch-buffer
  "O" 'counsel-fzf)

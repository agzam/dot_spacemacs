(global-set-key (kbd "C-x C-p") 'org-pomodoro)
(global-set-key (kbd "C-x p") 'org-pomodoro)
(evil-define-key 'insert org-mode-map (kbd "M-RET") 'ag/org-meta-return)
(evil-define-key 'insert org-mode-map (kbd "RET") 'org-return-indent)
(evil-define-key 'insert org-mode-map (kbd "<S-return>") 'org-return)

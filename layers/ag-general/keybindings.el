;;; keybindings.el --- ag-general layer keybindings file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Ag Ibragimov <agzam.ibragimov@gmail.com>
;; URL: https://github.com/agzam/dot-spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;;; disable nonsensical keys
(dolist (key '("s-n" "s-p" "s-q" "s-m" "H-q" "C-x C-c"))
  (unbind-key (kbd key)))

;;;; don't quit helpful on Esc
(evil-define-key 'motion help-mode-map (kbd "<escape>") nil)

(evil-define-key 'normal diff-mode-map "q" #'quit-window)

(global-set-key (kbd "C-x b") 'spacemacs-layouts/non-restricted-buffer-list-helm)
(global-set-key (kbd "C-x C-b") 'spacemacs-layouts/non-restricted-buffer-list-helm)

(when (eq system-type 'darwin)
  (global-set-key (kbd "s-B") 'lazy-helm/helm-mini)
  (global-set-key (kbd "s-b") 'spacemacs-layouts/non-restricted-buffer-list-helm)
  (global-set-key (kbd "H-B") 'lazy-helm/helm-mini)
  (global-set-key (kbd "H-b") 'spacemacs-layouts/non-restricted-buffer-list-helm)
  (global-set-key (kbd "s-[") #'spacemacs/persp-go-prev)
  (global-set-key (kbd "s-]") #'spacemacs/persp-go-next)
  (global-set-key (kbd "H-[") #'spacemacs/persp-go-prev)
  (global-set-key (kbd "H-]") #'spacemacs/persp-go-next))

(with-eval-after-load 'helm
  (define-key helm-map (kbd "C-c M-i") 'helm-copy-to-buffer))
;;;; restore vanilla universal argument binding
(define-key evil-normal-state-map (kbd "C-u") 'universal-argument)

;;;; wrap `sp-up-sexp` "Move forward out of one level of parentheses", so it can be used in evil-lispy
(with-eval-after-load 'evil-lisp-state
  (evil-lisp-state-enter-command sp-up-sexp)

  (defun sp-reindent ()
    (interactive)
    (save-excursion
      (er/expand-region 2)
      (evil-indent (region-beginning) (region-end))))

  (evil-lisp-state-enter-command sp-reindent)
  (spacemacs/set-leader-keys
    "kf" #'evil-lisp-state-sp-up-sexp
    "k=" #'evil-lisp-state-sp-reindent))

(spacemacs/set-leader-keys
  "qq" nil                           ;; no unexpected exits
  "qQ" #'spacemacs/prompt-kill-emacs
  "s/" #'engine/search-google
  "jj" #'avy-goto-char-timer
  "ja" #'beginning-of-defun
  "je" #'end-of-defun
  "swg" #'helm-google-suggest
  ;; "ou" #'spacemacs/avy-open-url
  ;;;; add a page-break
  "iP" (kbd "i C-q C-l <RET><escape>"))

(define-key evil-normal-state-map (kbd "s-a") #'mark-whole-buffer)
(define-key evil-normal-state-map "Q" 'bury-buffer)
(define-key evil-normal-state-map (kbd "C-S-e") 'scroll-other-window)
(define-key evil-normal-state-map (kbd "C-S-y") 'scroll-other-window-down)
(define-key evil-insert-state-map (kbd "C-'") #'delete-backward-char)

;;;; ---------------
;;;; Smartparens
;;;; ---------------
(dolist (map (list evil-insert-state-map))
  (define-key map "\M-l" 'sp-slurp-hybrid-sexp)
  (define-key map "\M-h" 'sp-forward-barf-sexp)
  (define-key map "\M-L" 'sp-backward-slurp-sexp)
  (define-key map "\M-H" 'sp-backward-barf-sexp))

;;;; making Info-mode keys more suitable for Evil
(define-key Info-mode-map (kbd "H") 'Info-up)
(define-key Info-mode-map (kbd "C-o") 'Info-prev)
(define-key Info-mode-map (kbd "C-i") 'Info-next)
(unbind-key "n" Info-mode-map)
(unbind-key "p" Info-mode-map)

;;;; -----------
;;;; Company
;;;; -----------
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-f") 'company-search-candidates))


;;; keybindings.el ends here

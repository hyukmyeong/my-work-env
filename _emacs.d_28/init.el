;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (초기화)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents) (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

;; created by ~/.emacs.d/custom
;; package-selected-packages are install by me(user)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-statistics company-irony-c-headers company-irony auto-complete company-c-headers sr-speedbar zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (초기화)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (테마, 윈도우)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-city-lights t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)

  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-face-attribute 'default nil :height 96)
(set-frame-font "DejaVu Sans Mono" t t)


;; scroll 부드럽게
;; for smooth scrolling and disabling the automatical recentering of emacs when moving the cursor
(setq-default scroll-margin 0
              scroll-conservatively 0
              scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)


;; always show line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; (global-linum-mode 1)


(windmove-default-keybindings 'control)

;; window size
(global-set-key (kbd "<S-up>") 'shrink-window)
(global-set-key (kbd "<S-down>") 'enlarge-window)
(global-set-key (kbd "<S-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<S-right>") 'enlarge-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (테마, 윈도우)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (helm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'setup-general)
(if (version< emacs-version "24.4") (require 'setup-ivy-counsel) (require 'setup-helm) (require 'setup-helm-gtags))

;(setq
; helm-gtags-ignore-case t
; helm-gtags-auto-update t
; helm-gtags-use-input-at-cursor t
; helm-gtags-pulse-at-cursor t
; helm-gtags-prefix-key "\C-cg"
; helm-gtags-suggested-key-mapping t
; )

;(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
;(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
;(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(define-key helm-gtags-mode-map (kbd "M-g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "M-g j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-g .") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-g ,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "M-g <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "M-g >") 'helm-gtags-next-history)
;(require 'helm-gtags)
;; Enable helm-gtags-mode
;(add-hook 'dired-mode-hook 'helm-gtags-mode)
;(add-hook 'eshell-mode-hook 'helm-gtags-mode)
;(add-hook 'c-mode-hook 'helm-gtags-mode)
;(add-hook 'c++-mode-hook 'helm-gtags-mode)
;(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; ~/.emacs.d/helm-cscope.el 파일 하단에 (add-to-list 'load-path ".") 를 추가해야 함
(require 'xcscope)
(require 'helm-cscope)

;; Enable helm-cscope-mode
;(add-hook 'c-mode-hook 'helm-cscope-mode)
;(add-hook 'c++-mode-hook 'helm-cscope-mode)

;; Set key bindings
;(eval-after-load "helm-cscope"
;  '(progn
;     (define-key helm-cscope-mode-map (kbd "C-\\ s") 'cscope-find-this-symbol)
;     (define-key helm-cscope-mode-map (kbd "C-\\ g") 'cscope-find-global-definition)
;     (define-key helm-cscope-mode-map (kbd "C-\\ e") 'cscope-find-called-function)
;     (define-key helm-cscope-mode-map (kbd "C-\\ c") 'cscope-find-calling-this-function)
;     (define-key helm-cscope-mode-map (kbd "C-t") 'cscope-pop-mark)))

(global-set-key (kbd "M-s") 'helm-swoop)
(global-set-key (kbd "C-[ s") 'cscope-find-this-symbol)
(global-set-key (kbd "C-[ t") 'cscope-pop-mark)

;; helm-projectile-find-file은 어디에서 실행했든 .git을 인식하고
;; projectile-find-file은 실행한 폴더에서만 파일을 찾아줌
(global-set-key (kbd "M-p p") 'projectile-dired)
;(global-set-key (kbd "M-p f") 'project-find-file)
(global-set-key (kbd "M-p f") 'projectile-find-file)
(global-set-key (kbd "M-p s") 'projectile-switch-project)
(global-set-key (kbd "M-p g") 'projectile-grep)
(global-set-key (kbd "M-p n") 'find-file)
(global-set-key (kbd "M-p b") 'sr-speedbar-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (helm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (speedbar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'sr-speedbar)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-right-side nil) ; put on left side
(setq sr-speedbar-width 35)
(setq sr-speedbar-max-width 35)
(setq speedbar-show-unknown-files t)

;(setq speedbar-show-unknown-files t)
;(setq speedbar-use-images nil) ; use text for buttons
;(setq window-size-fixed 'width))
;(with-current-buffer sr-speedbar-buffer-name

;(use-package dashboard
;  :ensure t
;  :defer t
;  :init
;  (dashboard-setup-startup-hook)
;  :config
;  (sr-speedbar-open)
;  )

;(use-package sr-speedbar
;  :ensure t
;  :defer t
;  :init
;  (setq sr-speedbar-right-side nil)
;  (setq speedbar-show-unknown-files t)
;  (setq sr-speedbar-width 35)
;  (setq sr-speedbar-max-width 35)
;  (setq speedbar-use-images t)
;  (setq speedbar-initial-expansion-list-name "quick buffers")
;  (define-key speedbar-mode-map "\M-p" nil)

;(sr-speedbar-open)
;  :config
;  (with-current-buffer sr-speedbar-buffer-name
;    (setq window-size-fixed 'width)
;   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (speedbar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (coding style)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; block and indent
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)

;; use space to indent by default
(setq-default indent-tabs-mode nil)
;(setq tab-width 2)
;(setq cmake-tab-width 4)

;; Package: clean-aindent-mode
;(require 'clean-aindent-mode)
;(add-hook 'prog-mode-hook 'clean-aindent-mode)

;(add-hook 'c-mode-hook '
;  (lambda ()
;  (c-set-style "bsd")
;  (setq tab-width 2)
;  (setq c-basic-offset 2) ;; indent use only 2 blank
;  (setq indent-tabs-mode nil) ;; no tab
;))

;; function-args
; (require 'function-args)
; (fa-config-default)
; (define-key c-mode-map  [(tab)] 'company-complete)
; (define-key c++-mode-map  [(tab)] 'company-complete)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Available C style:
;; “gnu”, “k&r”, “bsd”, “whitesmith”, “stroustrup”, “ellemtel”, “linux”, “python”, “java”, “user”
;(setq
; c-default-style "k&r" ;; set style to "linux"
; )

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (coding style)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (ide)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq tags-revert-without-query 1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; company
(require 'company-c-headers)
(require 'company-cmake)

;; Use compilation database first, clang_complete as fallback.
(setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
					        irony-cdb-clang-complete))

(eval-after-load 'company '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-selection-wrap-around t)
(setq company-show-numbers "on")

(require 'cc-mode)
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/7.5.0/")


;; etc.
;(require 'setup-ggtags)
;(require 'setup-cedet)
(require 'setup-editing)

;(load-file (concat user-emacs-directory "/cedet/cedet-devel-load.el"))
;(load-file (concat user-emacs-directory "cedet/contrib/cedet-contrib-load.el"))

;;(set
 ;; use gdb-many-windows by default
;; gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
;; gdb-show-main t
;; )

(setq-default ediff-diff-options "-w"
              ediff-split-window-function 'split-window-horizontally
              ediff-window-setup-function 'ediff-setup-windows-plain)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (ide)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start (etc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-shell-hook ()
  (local-set-key "C-c l" 'comint-clear-buffer))

(add-hook 'shell-mode-hook 'my-shell-hook)

(defun connect-otto ()
p  (interactive)
  (dired "/ssh:hyuk.myeong@10.178.97.152:/home/hyuk.myeong/work"))

(put 'erase-buffer 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish (etc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

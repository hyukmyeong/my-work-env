(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki start				              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default package-check-signature nil)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. helm에서 유용한 기능들 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-s") 'helm-swoop)
;(global-set-key (kbd "M-t") 'helm-for-files)
(global-set-key (kbd "M-t") 'helm-projectile-find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. helm cscope            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cscope를 파일이 있는 폴더에 직접 만들어버리기 때문에 전역적인 것을 사용하지 못 함
;; ~/.emacs.d/helm-cscope.el 파일 하단에 (add-to-list 'load-path ".") 를 추가해야 함
(require 'xcscope)
(require 'helm-cscope)
;; Enable helm-cscope-mode
(add-hook 'c-mode-hook 'helm-cscope-mode)
(add-hook 'c++-mode-hook 'helm-cscope-mode)
;; Set key bindings
(eval-after-load "helm-cscope"
  '(progn
     (define-key helm-cscope-mode-map (kbd "M-.") 'helm-cscope-find-this-symbol)
;     (define-key helm-cscope-mode-map (kbd "M-g g") 'helm-cscope-find-this-global-definition)
;     (define-key helm-cscope-mode-map (kbd "M-g c") 'helm-cscope-find-called-function)
;     (define-key helm-cscope-mode-map (kbd "M-g p") 'helm-cscope-find-calling-this-funtcion)
     (define-key helm-cscope-mode-map (kbd "M-,") 'helm-cscope-pop-mark)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. evil 	             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(defun evil-keyboard-quit ()
  "Keyboard quit and force normal state."
  (interactive)
  (and evil-mode (evil-force-normal-state))
  (keyboard-quit))

(define-key evil-normal-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-motion-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-insert-state-map   (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-window-map         (kbd "C-g") #'evil-keyboard-quit)
(define-key evil-operator-state-map (kbd "C-g") #'evil-keyboard-quit)

;; evil을 사용하면 helm의 M-. 가 동작하지 않기 때문에 아래 내용을 주석처리함
;; 위치 : ~/.emacs.d/evil/evil-maps.el
;;(define-key evil-normal-state-map (kbd "C-.") 'evil-repeat-pop)
;;(define-key evil-normal-state-map (kbd "M-.") 'evil-repeat-pop-next)

; 윈도우 이동 : shift + arrow
(windmove-default-keybindings)

;; scroll 부드럽게
;; for smooth scrolling and disabling the automatical recentering of emacs when moving the cursor
;;(setq scroll-conservatively 0
(setq-default scroll-margin 1
scroll-conservatively 0
scroll-up-aggressively 0.01
scroll-down-aggressively 0.01)

;; 테마 뭘로?
;doom-nord-light
;(setq doom-theme 'doom-nord-light)

;; block and indent
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;(add-hook 'c-mode-hook '
;  (lambda ()
;  (c-set-style "bsd")
;  (setq tab-width 2)
;  (setq c-basic-offset 2) ;; indent use only 2 blank
;  (setq indent-tabs-mode nil) ;; no tab
;))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mikki finish 				      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-c-headers sr-speedbar zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; hyuk.myeong extenstion (M-x load-file RET init.el)
(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "usr/include/c++/7.4.0/")

;(load-file (concat user-emacs-directory "/cedet/cedet-devel-load.el"))
;(load-file (concat user-emacs-directory "cedet/contrib/cedet-contrib-load.el"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
;(setq
; c-default-style "k&r" ;; set style to "linux"
; )

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(put 'erase-buffer 'disabled nil)

;(windmove-default-keybindings)
;(windmove-default-keybindings 'meta)
(windmove-default-keybindings 'control)

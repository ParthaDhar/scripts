;; autoloads.el
;; load�Ȥ��μ���

(load "utils")

;; Text�⡼�ɤ�ǥե���Ȥ�
(setq default-major-mode 'text-mode)

;; �����ȥ���ץ꡼��
(require 'auto-complete)
(global-auto-complete-mode t)

;; timidity-mode : TiMidity++ emacs front-end
(when (autoload-p 'timidity "timidity" "TiMidity++" 'interactive))

;; ruby-mode
(when (autoload-p 'ruby-mode "ruby-mode" "Ruby" 'interactive)
  (setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("ruby" . ruby-mode) interpreter-mode-alist)))

;; rd-mode
(when (autoload-p 'rd-mode "RD-mode" "RDtool" 'interactive)
  (setq auto-mode-alist (cons '("\\.rd$" . rd-mode) auto-mode-alist)))

;; php-mode
(when (autoload-p 'php-mode "php-mode" "PHP" 'interactive)
  (setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("php" . php-mode) interpreter-mode-alist)))

;; haskell-mode
(when (autoload-p 'haskell-mode "haskell-site-file" "Haskell" 'interactive)
  (setq auto-mode-alist
	(append '(("\\.hs$" . haskell-mode)
		  ("\\.hi$" . haskell-mode)
		  ("\\.gs$" . haskell-mode)
		  ("\\.lhs$" . haskell-mode)
		  ("\\.lgs$" . haskell-mode))
		auto-mode-alist))
  (setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode)
		("hugs" . haskell-mode)
		("php"	. php-mode))
	      interpreter-mode-alist))
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent))

;; gtags-mode : global ������
(when (autoload-p 'gtags-mode "gtags" "GNU GLOBAL" 'interactive)
  (setq gtags-mode-hook
	(function (lambda ()
		    (local-set-key "\M-f" 'gtags-find-tag)    ; override etags
		    (local-set-key "\M-r" 'gtags-find-rtag)   ; reverse tag
		    (local-set-key "\M-s" 'gtags-find-symbol) ; find
		    (local-set-key "\C-t" 'gtags-pop-stack)))); pop
  ;; C-mode �ΤȤ��Ͼ�� gtags ���ѡ�
  (defun-add-hook 'c-mode-common-hook (gtags-mode 1)))

;; sense-region.el : \C-spc �� region<->rectabgle ��ȥ��롣������
(when (autoload-p 'sense-region-on "sense-region" "sense-region" 'interactive)
  (sense-region-on))

;; emacs-w3m
(load-p "emacs-w3m")

;; �ѿ͸���ã
(when (autoload-p 'riece "riece" "Riece IRC Client for Emacs" 'interactive)
  (setq riece-channel-list-buffer-mode t)
  (setq riece-user-list-buffer-mode t)
  (setq riece-layout "spiral")
  (setq riece-addons
	'(;;riece-alias
	  riece-biff
	  riece-button
	  riece-ctcp
	  riece-ctlseq
	  riece-foolproof
	  riece-guess
	  riece-highlight
	  riece-history
	  riece-icon
	  riece-ignore
	  riece-keepalive
	  riece-keyword
	  riece-menu
	  riece-shrink-buffer
	  riece-toolbar
	  riece-unread
	  riece-url
	  riece-xface
	  riece-yank))
  (setq riece-max-buffer-size 8192)
  (setq riece-gather-channel-modes t)
  (setq riece-buffer-dispose-function nil);;'kill-buffer)
  (setq riece-ignore-discard-message t)
  (setq riece-default-coding-system 'utf-8)
  (setq riece-ctlseq-hide-controls t);; t or nil
  (setq riece-ctlseq-colors
	'("white" "black" "DarkBlue" "DarkGreen"
	  "red" "maroon" "purple" "orange"
	  "yellow" "green" "DarkCyan" "cyan"
	  "blue" "magenta" "gray" "DimGray")))
;;   (setq riece-server "ircnet"
;; 	riece-server-alist '(("ircnet" :host "irc.tokyo.wide.ad.jp")
;; 			     ("freenode" :host "chat.freenode.net"))
;; 	riece-startup-server-list '("ircnet")
;; 	riece-startup-channel-list '("#nadoka:*.jp ircnet"
;; 				     "#rrr:*.jp ircnet"))
;;   (add-hook 'riece-keyword-notify-functions
;; 	    (lambda (keyword message)
;; 	      (write-region
;; 	       (riece-format-message message t)
;; 	       nil "/dev/shm/riece.touch" 0)))
;;  (add-hook 'riece-after-switch-to-channel-functions
;; 	   (lambda (last)
;; 	     (call-process "rm" nil nil nil "/dev/shm/riece.touch")))
;;  (add-hook 'riece-keyword-notify-functions
;; 	   (lambda (keyword message)
;; 	     (let ((ring-bell-function nil)
;; 		   (visible-bell t))
;; 	       (ding)))))

(load-p "italk")

(when (autoload-p 'navi2ch "navi2ch" "navi2ch" 'interactive)
  (setq navi2ch-list-bbstable-url "http://menu.2ch.net/bbsmenu.html")
  (setq navi2ch-mona-enable t))

;; ��̶�Ĵ
(when (load-p "mic-paren")
  (paren-activate))

;; ���Ĥ�
(when (load-p "develock")
  (global-font-lock-mode t))

;; Open recent��������
;; (when (load-p "recentf")
;;  (recentf-mode 1)
;;  ;; Open recent ����¸�����
;;  (setq recentf-max-menu-items 16)
;;  (setq recentf-max-saved-items 48))

;; ʪ���԰�ư
(load-p "physical-line")

;; �ʤ�Ǥ⥿�֤Ǥ��ac-mdoe
;; (when (load-p "ac-mode")
;;  (setq ac-mode-exception '(dired-mode hex-mode ruby-mode))
;;  (add-hook 'find-file-hooks 'ac-mode-without-exception))

;; split���ޤ���Ȱ�ư��ɤ����
(when (load-p "windmove")
  (windmove-default-keybindings)
  (setq windmove-wrap-around t))

;; screen��emacs -nw�򺮤���Ȥ����Ĥ������ˤۤ����ʤ�
(when (and (not window-system)
	   (string-match "^xterm\\|^screen" (getenv "TERM"))
	   (load-p "term/xterm"))
  (defun-add-hook 'post-command-hook
    "update terminal hard status."
    (let ((buf (current-buffer)))
      (unless (eq buf hardstatus-update-last-visited)
	(send-string-to-terminal
	 (concat "\e]0;"
		 (encode-coding-string
		  (format-mode-line frame-title-format 0)
		  'utf-8 t)
		 "\a"))
	(setq hardstatus-update-last-visited buf))))
  (setq hardstatus-update-last-visited nil))
;; (when (and (load-p "xterm-frobs")
;; 	   (load-p "xterm-title")
;; 	   (not window-system))
;; 	   (string-match "^xterm\\|^screen" (getenv "TERM")))
;;   (xterm-title-mode 1))

;; ��ư��¸
(when (load-p "auto-save-buffers")
  (setq auto-save-buffers-regexp "^/[^:]+/")
  (run-with-idle-timer 0.1 t 'auto-save-buffers))

(when (load-p "uniquify")
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; diminish
(when (load-p "diminish")
  (diminish 'isearch-mode)
  ;; (diminish 'gtags-mode "G")
  (diminish 'abbrev-mode "Abbr")
  ;; (diminish 'ac-mode "[tab]")
  (diminish 'font-lock-mode "");ư���Ƥ�����������
  ;; �Ĥ��Ǥ�����major mode��񤭴������㤨
  (defun-add-hook 'lisp-interaction-mode-hook (setq mode-name "Lisp"))
  (defun-add-hook 'emacs-lisp-mode-hook (setq mode-name "elisp"))
  (defun-add-hook 'texinfo-mode-hook (setq mode-name "texi"))
  (defun-add-hook 'change-log-mode-hook (setq mode-name "CL")))

;; TRAMP
(when (load-p "tramp")
  (setq tramp-debug-buffer t)
  (setq tramp-default-method "scpx")
  (setq tramp-auto-save-directory "~/.emacs.d/tramp-auto-save")
  (setq tramp-verbose 3))

;; �����ζ���Ȥ��������
(load-p "trim-buffer")

;; 4����
(load-p "tab4")

;; �������ե�����������˳�ǧ
;(load-p "new-file-p")

;; emacs21��*scratch*��ä��Ƥ��ޤä��ᤷ���פ��򤷤��͸���
(load-p "persistent-scratch")

;; UNIX������
(load-p "unix-defaults")

;; ��¸�ط�������ΤǤ����Ĥϰ��ֺǸ�ˡ�
(load-p "configs")


;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

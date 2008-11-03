;; configs.el
;; �����

;;�⡼�ɥ饤��˺�����ؿ���ɽ��
;;�ɤ߹��߻��Τߥ������äƤ����Τ�����äȤ����Ƥʤ�
(which-func-mode)

;; blink��������
(blink-cursor-mode nil)

;; �ġ���С��Ȥ�? ���ϻȤ�󤱤�
(tool-bar-mode nil)

;; ��˥塼�С��Ȥ�?
(menu-bar-mode -1)

;; ��������С��Ȥ�?
(scroll-bar-mode -1)

;; �ۥ�����ޥ����Ȥ�? �ʤ�����Ȥ���
(mouse-wheel-mode 1)

;; xterm�Ȥ�gnome-terminal�Ȥ���
(xterm-mouse-mode 1)

;; ;; fringe(������;��Τ褦�˸����Ƥ륢��)
;; (fringe-mode 8)

;; ;; ����ɽ��
(display-time)

;; ���ֹ�����ֹ�
(line-number-mode t)
(column-number-mode t)

;; ����Ÿ��
(auto-image-file-mode)

;; interactive switch buffer
(iswitchb-mode)
(iswitchb-default-keybindings)

;; �Хå����åץե��������¸���ֻ���
;; CVS�Ǵ������Ƥ��Ƥ����ꤷ�Ƥ����Ȱ���
;; !path!to!file-name~ ����¸�����
(setq backup-directory-alist
      '(("." . "~/.emacs.d/backups")))

;; transient-mark
(setq transient-mark-mode t)

;;isearch �򿧤Ĥ���
(setq search-highlight t)
(setq query-replace-highlight t)
;;(setq isearch-lazy-highlight-initial-delay 0) ; obsolate
(setq lazy-highlight-initial-delay 0)

;; M-x woman
(setq woman-manpath '("/usr/local/man"
		      "/usr/share/man"
		      "/usr/local/share/man"
		      "/sw/man"
		      "/usr/share/man/ja_JP.ujis"))
(setq woman-cache-filename (expand-file-name "~/.emacs.d/woman-cache"))

;; �Хå����åפ��Ȥ���inode���Ѥ��Τ������ʤ�
(setq backup-by-copying t)

;;GC�ֳ�
(setq gc-cons-threshold 1000000)

;; ���ץ�å�����ɽ�� : ��ư��®���ʤ�
(setq inhibit-startup-message t)

;; �ӡ��ײ��Τ����˲���ȿž
(setq visible-bell t)

;; ���ޤ���礭���ե�����Ͽ��դ���Ȼ��֤�����Τǡ���¤����
(setq font-lock-maximum-size nil)

;; ;; fast-lock
;; (setq font-lock-support-mode 'fast-lock-mode)
;; (setq fast-lock-cache-directories '("~/.emacs.d/emacs-flc"))

;; auto-save�ξ��
(setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list/.saves-")

;; �Ǹ�˲��Ԥ��դ��롣
(setq require-final-newline t)

;; /tmp �Ǥ�ޤ�����������ɡ�
;; (setq temporary-file-directory "~/.emacs.d/tmp")
(setq temporary-file-directory "/dev/shm")

;; 1�Ԥ��ĥ������롣
(setq scroll-conservatively 1)

;;�����Ԥ�������ʤ�
;;emacs21�Ǥϥǥե���ȡ�
(setq next-line-add-newlines nil)

;; 80 ���Ȥ���äȡġ�
(setq fill-column 79)

;; *Messages* ��Ĺ��
(setq message-log-max 200)

;; .gz �ʥե�����Ȥ���Ʃ��Ū�˰���/��ĥ
(auto-compression-mode t)

;; apropos �򤢤���Ȥ��Ȥ�
(setq apropos-do-all t)

;; abbrev
;; (read-abbrev-file "~/.emacs.d/abbrev_defs")
;; (setq save-abbrevs t)

;; version control
(setq vc-follow-symlinks t)
(setq vc-suppress-confirm t)
(setq vc-command-messages t)

;; narrowing����Ȥ��ˤ��������ٹ𤷤Ƥ���Τ�������
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; ����������
(setq cursor-in-non-selected-windows nil)

;; ���Զ�Ĵ
(setq-default indicate-empty-lines t)

;; �Դ�(����ä��Ƥ⤤�����ʤ�)
;; (setq-default line-spacing 0)

;; Anthy! Anthy!
;; (set-input-method "japanese-anthy")
;; (set-input-method "japanese-prime")


;; C����Ϥ����귲

;; Ruby default style
(c-add-style "ruby"
	     '("bsd"
	       (c-offsets-alist
		(case-label . 2)
		(label . 2)
		(statement-case-intro . 2))))

;; �Ǥ������� stroustrup ��������
(defun-add-hook 'c-mode-common-hook
  (c-set-style "Stroustrup")
  (c-toggle-hungry-state 1)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

;; fullscreen
(set-frame-parameter nil 'fullscreen 'fullboth)
(defun toggle-fullscreen ()
  (interactive)
    (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
      nil
      'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)

;; Redo! (need byte-compile redo.el)
(when (require 'redo nil t)
  (define-key ctl-x-map (if window-system "U" "r") 'redo)
  (define-key global-map [?\C-.] 'redo))

;; �����Х��������
(load "global-set-key")

;; ������������
(load "custom")


;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

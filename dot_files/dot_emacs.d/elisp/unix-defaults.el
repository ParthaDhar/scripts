;; Unix default settings

;; ���ܸ�����
(set-language-environment 'Japanese)
;; �Ƕ�⤦$LANG�Ǥ�����Ȥ������ˤʤä���
;; (set-default-coding-systems 'euc-jp-unix)
;; (set-buffer-file-coding-system 'euc-jp-unix)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'euc-jp-unix)
;; (setq file-name-coding-system 'euc-jp-unix)
;; (set-clipboard-coding-system 'iso-2022-jp-unix)
;; (setq default-process-coding-system '(undecided . euc-jp-unix))

(if window-system
  (progn
    (set-default-font "Bitstream Vera Sans Mono-10")
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      '("VL �����å�" . "unicode-bmp"))
;;�ե졼������
    (setq default-frame-alist
          (append (list '(top . 50) ; ��ư����ɽ�����֡ʾ夫���
                        '(left . 50) ; ��ư����ɽ�����֡ʺ������
                        '(width . 150) ; ��ư���Υ�����������
                        '(height . 70) ; ��ư���Υ������ʽġ�
                        '(foreground-color . "#FFFFFF") ; ʸ���ο�
                        '(background-color . "gray30") ; �طʤο�
                        '(cursor-color . "gray") ; ��������ο�
                   )
                  default-frame-alist))
;;�꡼�����˿����դ���
    (setq transient-mark-mode t)
;;�ե���ȥ�å�
    (global-font-lock-mode 1)
    (setq font-lock-support-mode 'jit-lock-mode)
;; ���Ť��Ϻ���¤�
    (setq font-lock-maximum-decoration t)
;; �ǥե���Ȥο��Ť����Ѥ���
    (add-hook 'font-lock-mode-hook '(lambda ()
      (set-face-foreground 'font-lock-builtin-face "spring green")
      (set-face-foreground 'font-lock-comment-face "slate gray")
      (set-face-foreground 'font-lock-string-face  "spring green")
      (set-face-foreground 'font-lock-keyword-face "khaki")
      (set-face-foreground 'font-lock-constant-face "violet")
      (set-face-foreground 'font-lock-function-name-face "hot pink")
      (set-face-foreground 'font-lock-variable-name-face "hot pink")
      (set-face-foreground 'font-lock-type-face "cyan")
      (set-face-foreground 'font-lock-warning-face "magenta")
      (set-face-bold-p 'font-lock-function-name-face t)
      (set-face-bold-p 'font-lock-warning-face nil)
    ))
))
;;


;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

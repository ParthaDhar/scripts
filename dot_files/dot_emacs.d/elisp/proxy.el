;; proxy.el
;; �ץ��������С�������

;; Proxy�����Ѥ���ʤ�global-proxy-use��t��
(defvar global-proxy-use nil)
(defvar global-proxy-server "proxy.hoge.co.jp")
(defvar global-proxy-port 8080)
(defvar global-proxy-user nil)
(defvar global-proxy-password nil)

;; Proxy�Υ��󥪥դ��ڤ��ؤ��뤹��ؿ�
(defun global-proxy-use-toggle () ""
  (interactive)
  (setq global-proxy-use
        (not global-proxy-use))
  (message "%s %s"
           "Use Proxy:"
           (if global-proxy-use
               "on" "off")))

;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

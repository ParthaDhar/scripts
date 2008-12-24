;; $B%-!<%P%$%s%I@_Dj(B

;; $B$3$C$A$N(Bwidow$B$GJT=8$7$J$,$i$"$C$A$N(B*help*$B$r%9%/%m!<%k$H$+!#(B
(global-set-key "\M-V" 'scroll-other-window-down)

;; $BIaCJ!"%$%s%G%s%H$9$k$h$&$K$9$k(B
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

;; No more bobcat, no more keyswap!
(cond ((eq window-system 'x)
       (progn
	 (global-set-key [delete] 'delete-char)))
      ((eq window-system 'mac)
       t) ;; ok
      (t (keyboard-translate ?\C-h ?\C-?)))

;; auto-complete-mode$B$NM-8z(B/$BL58z$r@Z$jBX$($k(B
(define-key global-map "\C-x\C-a" 'auto-complete-mode)
(define-key global-map "\C-c\C-c\ c" 'auto-complete-mode)

;; Twitter
(define-key global-map "\C-c\C-c\ 1" 'twitter1-mode)
(define-key global-map "\C-c\C-c\ 2" 'twitter2-mode)
(define-key global-map "\C-c\C-c\ 3" 'twitter3-mode)
(define-key global-map "\C-c\C-c\ 4" 'twitter4-mode)

;; C-M-g $B$G$b(B keyboard-escape-quit $B$9$k(B
(global-set-key "\C-\M-g" 'keyboard-escape-quit)

;; \C-h $B$r(B backspace $B$K$9$k(B
(global-set-key "\C-h" 'delete-backward-char)

;; $B%&%#%s%I%&J,3d(B
(global-set-key [right] 'delete-other-windows)
(global-set-key [left] 'split-window-vertically)
(define-key global-map [up] 'find-file)
(define-key global-map [down] 'electric-buffer-list)
(define-key global-map "\C-c\C-c\ k" 'delete-other-windows)
(define-key global-map "\C-c\C-c\ j" 'split-window-vertically)
(define-key global-map "\C-c\C-c\ y" 'split-window-horizontally)

;; $BJ,3d$7$?%&%#%s%I%&$r;~7W2s$j$K0\F0(B
(define-key global-map "\C-c\C-c\ w" 'other-window)

;; $B%P%C%U%!$r(BM-n,M-p$B$G@Z$jBX$((B
(defun previous-buffer ()
  "Select previous window."
  (interactive)
  (bury-buffer))
(defun backward-buffer ()
  "Select backward window."
  (interactive)
  (switch-to-buffer
    (car (reverse (buffer-list)))))
(global-set-key "\M-n" 'previous-buffer)
(global-set-key "\M-p" 'backward-buffer)

;; $B%P%C%U%!%j%9%H(B
(define-key global-map "\C-x\C-b" 'electric-buffer-list)
(define-key global-map "\C-c\C-c\C-c" 'electric-buffer-list)

;; C-x C-w$B$r>e=q$-J]B8$K$9$k(B($BJLL>J]B8$O(BC-x w)
(define-key global-map "\C-x\C-w" 'save-buffer)
(define-key global-map "\C-x\ w" 'write-file)

;; $B%P%C%U%!@hF,(B/$BKvHx$X$N%+!<%=%k0\F0(B
(define-key global-map "\C-c\C-c\ a" 'beginning-of-buffer)
(define-key global-map "\C-c\C-c\ e" 'end-of-buffer)

;; $B%"%s%I%%(B/$B%j%I%%(B
(define-key global-map "\C-c\C-c\ u" 'undo)
(define-key global-map "\C-c\C-c\ r" 'redo)

;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

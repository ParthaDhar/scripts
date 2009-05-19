;; key-chord.el$B@lMQ%-!<%P%$%s%I@_Dj(B

;; yu $B$G(B auto-complete-mode$B$NM-8z(B/$BL58z$r@Z$jBX$($k(B
(key-chord-define-global "yu" 'auto-complete-mode)

;; $B%&%#%s%I%&0\F0(B
(key-chord-define-global "io" 'windmove-up)
(key-chord-define-global ",." 'windmove-down)
(key-chord-define-global "hj" 'windmove-left)
(key-chord-define-global ";:" 'windmove-right)

;; fg $B$G(B keyboard-escape-quit $B$9$k(B
(key-chord-define-global "fg" 'keyboard-escape-quit)

;; jk $B$G(B view-mode $B$r@Z$jBX$($k(B
(key-chord-define-global "jk" 'toggle-view-mode)

;; $B%P%C%U%!@Z$jBX$((B
(key-chord-define-global "m," 'previous-buffer)
(key-chord-define-global "ui" 'backward-buffer)

;; $B%P%C%U%!%j%9%H(B
(key-chord-define-global "kl" 'electric-buffer-list)

;; $B%P%C%U%!@hF,(B/$BKvHx$X$N%+!<%=%k0\F0(B
(key-chord-define-global "rt" 'beginning-of-buffer)
(key-chord-define-global "vb" 'end-of-buffer)

;; $B%"%s%I%%(B/$B%j%I%%(B
(key-chord-define-global "l;" 'undo)
(key-chord-define-global "op" 'redo)

;; $B%U%!%$%k$r3+$/(B
(key-chord-define-global "df" 'find-file)

;; $B%9%/%m!<%k(B
(key-chord-define-global "er" 'scroll-up)
(key-chord-define-global "cv" 'scroll-down)

;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End:

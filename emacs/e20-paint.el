;; Paint doesn't work so well in Emacs version 21 or earlier, but this
;; is how to get it up and running regardless.

(defun window-inside-pixel-edges (&optional window)
  (list 9 0 (* 7 80) (* 13 40)))
(paint 512 512)

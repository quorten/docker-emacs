;; jesse-ciphers.el -- Documentation and code to aid in reverse
;; engineering undocumented data and file formats from Jesse.

;; The following functions are useful functions for decoding messages
;; from Jesse that are already provided with Emacs:
;; * upcase-region
;; * downcase-region
;; * capitalize-region
;; * reverse-region
;; * rot13-region
;; * uudecode-decode-region
;; * base64-decode-region
;; * base64-encode-region

;; The following new functions provided by this Emacs Lisp package
;; help with decoding messages:
;; * toggle-case-in-region
;; * reverse-words
;; * reverse-chars-in-region
;; * jesse-loc-decode-in-region

;; Based off of code found in Stack Overflow:
;; 20160922/http://stackoverflow.com/questions/18257573/how-to-toggle-letter-cases-in-a-region-in-emacs
(defun toggle-case-in-region (beg end)
  (interactive "*r")
  (let ((i 0)
	(return-string "")
	(input (buffer-substring-no-properties beg end)))
    (while (< i (- end beg))
      (let ((current-char (substring input i (+ i 1))))
	(if (string= (substring input i (+ i 1))
		     (downcase (substring input i (+ i 1))))
	    (setq return-string
		  (concat return-string
			  (upcase (substring input i (+ i 1)))))
	  (setq return-string
		(concat return-string
			(downcase (substring input i (+ i 1)))))))
      (setq i (+ i 1)))
    (delete-region beg end)
    (insert return-string)))

;; 20160922/https://www.emacswiki.org/emacs/ReverseWords
(defun reverse-words-in-region (beg end)
  "Reverse the order of words in region."
  (interactive "*r")
  (apply
   'insert
   (reverse
    (split-string
     (delete-and-extract-region beg end) "\\b"))))

;; Note: The following 3 functions are defined to help so that the
;; code can work in older versions of Emacs that cannot reverse
;; vectors directly.
(defun seq-to-list (seq-input)
  (defun inner-seq-to-list (result input pos)
    (if (< pos (length input))
	(inner-seq-to-list
	 (append result (list (elt input pos))) input (+ 1 pos))
      result))
  (inner-seq-to-list nil seq-input 0))

(defun string-to-list (str-input)
  (seq-to-list (vconcat str-input)))

(defun reverse-string (str-input)
  (concat (reverse (string-to-list str-input))))

(defun reverse-chars-in-region (beg end)
  (interactive "*r")
  (insert (reverse-string (delete-and-extract-region beg end))))

(defun jesse-loc-decode (jesse-string)
  (reverse-string (base64-decode-string (reverse-string jesse-string))))

(defun jesse-loc-decode-in-region (beg end)
  (interactive "*r")
  (insert (jesse-loc-decode (delete-and-extract-region beg end))))

(provide 'jesse-ciphers)

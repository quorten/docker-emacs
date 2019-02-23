;; Why does Emacs Rudel not work correctly when users are concurrently
;; editing and one does a `fill-paragraph'?  Try this test case
;; yourself to reveal the problem.  Run the following code in one
;; editor, and do some normal text typing editing in another editor.

(defun interrupt-test ()
  (interactive)
    (fill-paragraph))

(progn
  (run-at-time "10.0 sec" nil #'interrupt-test)
  (run-at-time "10.1 sec" nil #'interrupt-test)
  (run-at-time "10.2 sec" nil #'interrupt-test)
  (run-at-time "10.3 sec" nil #'interrupt-test)
  (run-at-time "10.4 sec" nil #'interrupt-test)
  (run-at-time "10.5 sec" nil #'interrupt-test)
  (run-at-time "10.6 sec" nil #'interrupt-test)
  (run-at-time "10.7 sec" nil #'interrupt-test)
  (run-at-time "10.8 sec" nil #'interrupt-test)
  (run-at-time "10.9 sec" nil #'interrupt-test)

  (run-at-time "11.0 sec" nil #'interrupt-test)
  (run-at-time "11.1 sec" nil #'interrupt-test)
  (run-at-time "11.2 sec" nil #'interrupt-test)
  (run-at-time "11.3 sec" nil #'interrupt-test)
  (run-at-time "11.4 sec" nil #'interrupt-test)
  (run-at-time "11.5 sec" nil #'interrupt-test)
  (run-at-time "11.6 sec" nil #'interrupt-test)
  (run-at-time "11.7 sec" nil #'interrupt-test)
  (run-at-time "11.8 sec" nil #'interrupt-test)
  (run-at-time "11.9 sec" nil #'interrupt-test))

;; Here's what's happening.  When you run `fill-paragraph', all of the
;; intermediate changes are forwarded to the server and clients
;; correctly, it's just that when they happen so quickly and at the
;; same time another user is editing, then things get jumbled up.
;; This is unfortunate.  I thought this was specifically what
;; concurrent editing protocols were supposed to avoid.  Well, after
;; using Emacs Rudel for a while in real world use, I now know for
;; sure that it is a little bit buggy.

;; Unfortunately, I also know from experience of what happened to
;; early web browsers that when this is the case, it is more frequent
;; for projects to get abandoned than it is for them to get fixed,
;; especially when there is some competing solution that is already
;; working.

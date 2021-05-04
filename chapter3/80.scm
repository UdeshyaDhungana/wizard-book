
;; include 78.scm before this

(define (rlc R L C vC0 iL0 dt)
  (define iL (integral (delay diL) iL0 dt))
  (define vC (integral (delay (scale-stream iL (/ -1 C)))
		       vC0
		       dt))
  (define diL (add-streams (scale-stream vC (/ 1 L))
			   (scale-stream iL (/ (- R) L))))
  iL)


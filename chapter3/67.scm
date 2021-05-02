
;; producing whole net of pairs

;; load 66.scm before this file

;; simple af
(define (pair-net s t)
  (cons-stream (list (stream-car s) (stream-car t))
	       (interleave (stream-map (lambda (x)
			     (list (stream-car s) x))
				       (stream-cdr t))
			   (pair-net (stream-cdr s) t))))

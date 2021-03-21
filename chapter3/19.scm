
;; Redoing 3.18 with constant space

;; Tortoise-Hare algorithm

;; just to make it a bit easy

(define (has-cycle? x)
  (define (helper a b first-time)
    (cond ((or (null? b)
	       (null? (cdr b))) false)
	  ((or first-time
	       (not (eq? a b)))
	    (helper (cdr a) (cddr b) false))
	   (else true)))
  (helper x x true))

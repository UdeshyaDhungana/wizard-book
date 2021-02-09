
					;Implementation of union of two sets
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


(define (union-set s1 s2)
  (define (transfer result from)
    (cond ((null? from) result)
	  ((element-of-set? (car from) result) (transfer result (cdr from)))
	  (else (transfer (cons (car from) result) (cdr from)))))
  (transfer s1 s2))

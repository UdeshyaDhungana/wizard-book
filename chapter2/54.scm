
					;Equal procedure

(define (equal? la lb)
  (let ((both-pair (and (pair? la) (pair? lb)))
	(both-atomic (and (not (pair? la)) (not (pair? lb)))))

    (cond (both-pair (and (equal? (car la) (car lb)) (equal? (cdr la) (cdr lb))))
	  (both-atomic (eq? la lb))
	  (else #f))))

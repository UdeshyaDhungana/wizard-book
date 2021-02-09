
					;Implementing union for ordered list

(define (union-set a b)
  (cond ((null? a) b)
	((null? b) a)
   (else (let ((x1 (car a))
	 (x2 (car b)))
     (cond ((= x1 x2) (cons x1 (union-set (cdr a) (cdr b))))
	   ((> x1 x2) (cons x2 (union-set a (cdr b))))
	   (else (cons x1 (union-set (cdr a) b))))))))

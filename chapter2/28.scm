					;Fringe

(define (fringe x)
  (if (null? x)
      ()
      (if (list? (car x))
	  (append (fringe (car x)) (fringe (cdr x)))
	  (cons (car x) (fringe (cdr x))))))

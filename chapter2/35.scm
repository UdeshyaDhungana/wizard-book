					;Redifinition of count-leaves as accumulation

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) ())
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))

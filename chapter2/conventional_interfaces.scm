					;Filter procedure
					;This procedure selects only those items which satisfy the predicate and filters them out
(define (filter predicate sequence)
  (if (null? sequence)
      ()
      (if (predicate (car sequence))
	  (cons (car sequence) (filter predicate (cdr sequence)))
	  (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5))

(define (enumerate-interval low high)
  (if (> low high)
      ()
      (cons low (enumerate-interval (+ low 1) high))))

					;Now we may define enumerate-tree as follows

(define (enumerate-tree tree)
  (cond ((null? tree) ())
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))

					;Accumulate procedure that accumulates from a list

					;The initial argument is needed because for different type of accumulation, weeneed differnet types
					;initial values, for example, 1 for multiplication and 0 for addition

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))


					;Now we have
					;Enumeration, filter, accumulation
					;Let's combine them to form a sum-odd-square of tree function
					;This function

(define (sum-odd-square tree)
  (accumulate + 0
	      (map square
		   (filter even? (enumerate-tree tree)))))


					;function to print only the even fibonacci numbers
(define (even-fibs n)
  (accumulate cons ()
	      (filter even? (map fib (enumerate-interval 0 n)))))

					;where,
(define (fib x)
  (cond ((= x 0) 0)
	((= x 1) 1)
	(else (+ (fib (- x 1)) (fib (- x 2))))))

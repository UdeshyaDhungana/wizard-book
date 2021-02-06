					;Another way to represent cons car and cdr

(define (cons x y)
	(* (expt 2 x) (expt 3 y)))

(define (car z)
	(define (iter x result)
	(if (= (remainder x 2) 0)
		(iter (/ x 2) (+ 1 result))
		result))
	(iter z 0))

(define (cdr z)
	(define (iter x result)
	(if (= (remainder x 3) 0)
		(iter (/ x 3) (+ 1 result))
		result))
	(iter z 0))


(car (cons 2 3))
(cdr (cons 2 3))

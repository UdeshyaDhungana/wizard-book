
					;Let's make derivative
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum (make-product (multiplier exp)
				 (deriv (multiplicand exp) var))
		   (make-product (deriv (multiplier exp) var)
				 (multiplicand exp))))
	(else "unknown expression type -- DERIV" exp)))


(define (variable? x) (symbol? x))

					;Same variable?
					;The first predicate of and statement is needed because
					;(eq? x 'x) returns #t for any value of x

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (list '+ a1 a2))

(define (make-product p1 p2)
  (list '* p1 p2))

(define (sum? s)
  (and (pair? s) (eq? (car s) '+)))

(define (addend s)
  (cadr s))

(define (augend s)
  (caddr s))

(define (product? p)
  (and (pair? p) (eq? (car p) '*)))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (caddr p))

					;However, with the construct of make-sum and make-product, even the trivial derivatives
					;become complex because the answers are not simplified
					;HINT: try  (deriv '(* (* x y) (+ x 3)) 'x)
					;You can see right away why this isn't feasible

					;Let's change make-sum and make-product

;=number?  is defined below
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2) (+ a1 a2)))
	(else (list '+ a1 a2))))


					;First test (number? exp) is needed because exp may not be a number
					;After we've confirmed that exp is a number, we test its equality with a number

(define (=number? exp num)
  (and (number? exp) (= exp num)))


					;make-product
(define (make-product p1 p2)
  (cond ((or (=number? p1 0) (=number? p2 0)) 0)
	((=number? p1 1) p2)
	((=number? p2 1) p1)
	((and (number? p1) (number? p2)) (* p1 p2))
	(else (list '* p1 p2))))

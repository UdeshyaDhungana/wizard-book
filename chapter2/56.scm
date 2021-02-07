
					;Implementing exponentiation



(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

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

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2) (+ a1 a2)))
	(else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product p1 p2)
  (cond ((or (=number? p1 0) (=number? p2 0)) 0)
	((=number? p1 1) p2)
	((=number? p2 1) p1)
	((and (number? p1) (number? p2)) (* p1 p2))
	(else (list '* p1 p2))))

(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) '**)))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
	((=number? e 1) b)
	(else (list '** b e))))


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
	((exponentiation? exp)
	 (make-product (exponent exp)
		       (make-product (make-exponentiation (base exp) (- (exponent exp) 1))
				     (deriv (base exp) var))))
	(else "unknown expression type -- DERIV" exp)))

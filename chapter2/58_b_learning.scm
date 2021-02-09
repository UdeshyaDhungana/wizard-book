
					;Let's implement this entire thing

					;To tell what sort of expression we have, we need to find out what operator will be the last one applied to the terms should we attempt to evaluate the expression. This has to be the operator with the lowest precedence among all the visible ones. So the predicates sum? and product? will seach out the lowest precedence operator and compare it to '+ and '* respectively.

(define (sum? expr)
  (eq? '+ (smallest-op expr)))

(define (product? expr)
  (eq? '* (smallest-op expr)))

					;Returns the result of accumulating over the sequence using the 'operation'
(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))


(define (smallest-op expr)
  (accumulate (lambda (a b)
		(if (operator? b)
		    (min-precedence a b)
		    a))
	      'maxop
	      expr))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;This can be understood from this example
(accumulate (lambda (a b)
	      (if (> a b)
		  a
		  b))

	    0 (list 1 2 3 4 5))
					;This calculates the largest value in the list, given that 0 is the initial smallest value
					;The procedure (smallest-op) is analogous to this one
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define *precedence-table*
  '( (maxop . 100)
     (minop . -100)
     (+ . 0)
     (* . 1) ))
					;is a list of pair

(define (operator? x)
  (define (looper op-pair)
    (cond ((null? op-pair) #f)
	  ((eq? x (caar op-pair)) #t)
	  (else (looper (cdr op-pair)))))
  (looper *precedence-table*))
					;Here, we are essentially checking whether x belongs to the first element of the precedence-table, i.e. whether or not x is an operator

					;If precedence of a is less than that of b, return a, b otherwise
(define (min-precedence a b)
  (if (precedence<? a b)
      a
      b))

(define (precedence<? a b)
  (< (precedence a) (precedence b)))

					;Return the precedence value for given operator from the *precedence-table*
(define (precedence op)
  (define (loop op-pair)
    (cond ((null? op-pair)
					;Remember, precedence is compared in the above procedures, so for an expression not in the precedence-table,
	   ;it must be that it's precedence is maximum
	   (precedence 'maxop))
	   ((eq? op (caar op-pair))
	   (cdar op-pair))
	  (else
	   (loop (cdr op-pair)))))
  (loop *precedence-table*))

					;First part
(define (augend expr)
  (let ((a (cdr (memq '+ expr))))
    (if (singleton? a)
	(car a);If the latter part has only one element, then the augend is itself
	a)))

(define (singleton? a)
  (= 1 (length a)))

(define (prefix sym list)
  (if (or (null? list) (eq? sym (car list)))
      '()
      (cons (car list) (prefix sym (cdr list)))))

(define (addend expr)
  (let ((a (prefix '+ expr)))
    (if (singleton? a)
	(car a)
	a)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2) 
        ((=number? a2 0) a1) 
        ((and (number? a1) (number? a2)) 
         (+ a1 a2)) 
        (else (list a1 '+ a2))))

					;Similar procedures are for product
(define (multiplier expr) 
  (let ((m (prefix '* expr))) 
    (if (singleton? m) 
        (car m) 
        m))) 

(define (multiplicand expr) 
  (let ((m (cdr (memq '* expr)))) 
    (if (singleton? m) 
        (car m) 
        m))) 

(define (make-product m1 m2) 
  (cond ((=number? m1 1)  m2) 
        ((=number? m2 1)  m1) 
        ((or (=number? m1 0) (=number? m2 0))  0) 
        ((and (number? m1) (number? m2)) 
         (* m1 m2)) 
        (else (list m1 '* m2))))

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


(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))


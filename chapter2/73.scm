
;; a) Because number and variable do not have operators to be dispatched,
;; their type is not dictated by their operators

;; b)
(define (install-sum-package)
  (define (make-sum a b)
    (cons a b))
  (define (addend s)
    (car s))
  (define (augend s)
    (cdr s))
  (define (tag x) (attach-tag '+ x))
  (define (deriv-sum s)
    (tag (make-sum (deriv (addend s)) (deriv (augend s)))))

  (put 'deriv '(+) deriv-sum)
  (put 'make-sum '+ (lambda (x y)
		      (tag (make-sum x y))))
  'done)

(define (make-sum x y)
  ((get 'make-sum '+) x y))


(define (install-product-package)
  (define (make-product p q)
    (cons p q))
  (define (muliplier p) (car p))
  (define (multiplicand p) (cdr p))

  (define (tag x) (attach-tag '* x))
  
  (define (deriv-product p var)
    (make-sum (make-product (multiplier p)
			    (tag (deriv (multiplicand p) var)))
	      (make-product (multiplicand p)
			    (tag (deriv (multiplier p) var)))))

  (put 'deriv '(*) deriv-product)
  (put 'make-product '*
       (lambda (x y)
	 (tag (make-product x y))))
  'done)

(define (make-product x y)
  ((get 'make-product '*) x y))


(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


;; Implementation of exponential

(define (install-exponential-package)
  (define (make-exponential base power)
    (cons base power))
  (define (base exp)
    (car exp))
  (define (power exp)
    (cdr exp))
  (define (tag x) (attach-tag 'exp x))

  (define (deriv-exp term)
    (make-product (power term) (tag (make-exponential (base term)
						      (- (power term) 1)))))
  (put 'deriv '(exp) deriv-exp)
  (put 'make-exponential 'exp (lambda (b p)
				(tag (make-exponential b p))))
  'done)

(define (make-exponential base power)
  ((get 'make-exponential 'exp) base power))


;; c. We should change the order of arguments in put respectively. That's all we need to do!

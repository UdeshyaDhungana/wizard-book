#lang racket

(require "./symbolic_differentiation.rkt")

(define (exponentiation? e)
  (and (pair? e) (eq? (car e) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list '** b e))))


;; redefine deriv to include exponentiation
(define (deriv expression var)
  (cond ((number? expression) 0)
        ((variable? expression)
         (if (same-variable? expression var) 1 0))
        ((sum? expression)
         (make-sum (deriv (addend expression) var)
                   (deriv (augend expression) var)))
        ((product? expression)
         (make-sum (make-product (multiplier expression)
                                 (deriv (multiplicand expression) var))
                   (make-product (deriv (multiplier expression) var)
                                 (multiplicand expression))))
        ((exponentiation? expression)
         (make-product (exponent expression)
                       (make-product (make-exponentiation (base expression)
                                                          (make-sum (exponent expression) -1))
                                     (deriv (base expression) var))))
        (else "unknown expression type -- DERIV" exponent)))

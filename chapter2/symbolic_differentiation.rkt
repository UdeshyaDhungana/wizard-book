#lang racket

(require "../lib.rkt")

;; representing expressions
(define (variable? e)
  (symbol? e))

(define (same-variable? a b)
  (and (variable? a) (variable? b) (eq? a b)))

(define (sum? e)
  (and (pair? e) (eq? (car e) '+)))

(define (addend e)
  (cadr e))

(define (augend e)
  (caddr e))

;; (define (make-sum a1 a2)
;;   (list '+ a1 a2))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (product? e)
  (and (pair? e) (eq? (car e) '*)))

(define (multiplier e)
  (cadr e))

(define (multiplicand e)
  (caddr e))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))


;; calculating derivative using implementation of expressions
(define (deriv expressn var)
  (cond ((number? expressn) 0)
        ((variable? expressn)
         (if (same-variable? expressn var) 1 0))
        ((sum? expressn)
         (make-sum (deriv (addend expressn) var)
                   (deriv (augend expressn) var)))
        ((product? expressn)
         (make-sum (make-product (multiplier expressn)
                                 (deriv (multiplicand expressn) var))
                   (make-product (deriv (multiplier expressn) var)
                                 (multiplicand expressn))))
        (else (error "unknown expressnression type: DERIV" expressn))))

(provide variable?
         same-variable?
         sum?
         addend
         augend
         make-sum
         product?
         multiplier
         multiplicand
         make-product
         deriv)

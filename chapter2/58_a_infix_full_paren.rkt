#lang racket

(require "../lib.rkt")

(define (variable? x)
  (symbol? x))

(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))

(define (sum? e)
  (and (pair? e) (eq? '+ (cadr e))))

(define (addend e)
  (car e))

(define (augend e)
  (caddr e))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list a1 '+ a2))))

(define (product? e)
  (and (pair? e) (eq? '* (cadr e))))

(define (multiplier e)
  (car e))

(define (multiplicand e)
  (caddr e))

(define (make-product p1 p2)
  (cond ((or (=number? p1 0) (=number? p2 0)) 0)
        ((=number? p1 1) p2)
        ((=number? p2 1) p1)
        ((and (number? p1) (number? p2)) (* p1 p2))
        (else (list p1 '* p2))))

;; had to copy this code
;; deriv on the other files uses functions from that file
;; instead of this one
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

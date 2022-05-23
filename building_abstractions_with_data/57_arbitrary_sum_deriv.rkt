#lang racket
;Changing representation of sum and product to handle arbritary number of terms

;; change only the representation, not the deriv prodcedure

(require "./symbolic_differentiation.rkt")

(define (make-sum x . y)
  ;; make sum for only 2 terms
  (define (make-sum-of-two a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (iter seq)
    (if (null? (cdr seq))
        (car seq)
        (make-sum-of-two (car seq) (iter (cdr seq)))))
  (iter (cons x y)))

(define (make-product x . y)
  (define (make-product-of-two m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (iter seq)
    (if (null? (cdr seq))
        (car seq)
        (make-product-of-two (car seq) (iter (cdr seq)))))
  (iter (cons x y)))

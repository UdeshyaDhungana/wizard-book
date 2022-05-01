#lang racket

;Implementation of union of two sets
(define (element-of-set? x given-set)
  (cond ((null? given-set) false)
        ((equal? x (car given-set)) true)
        (else (element-of-set? x (cdr given-set)))))


(define (union-set s1 s2)
  (define (remove-repeated seq result)
    (cond ((null? seq) result)
          ((element-of-set? (car seq) result)
           (remove-repeated (cdr seq) result))
          (else (remove-repeated (cdr seq)
                                 (cons (car seq) result)))))
  (remove-repeated (append s1 s2) '()))

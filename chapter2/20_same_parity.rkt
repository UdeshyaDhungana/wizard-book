#lang racket

(define (check-same-parity a b)
  (or (and (odd? a) (odd? b))
          (and (even? a) (even? b))))

(define (same-parity first . rest)
  (define (helper l)
    (cond ((null? l) l)
          ((check-same-parity (car l) first)
           (cons (car l) (helper (cdr l))))
          (else (helper (cdr l)))))
  (cons first (helper rest )))

(same-parity 1 2 3 4 5 6 7)

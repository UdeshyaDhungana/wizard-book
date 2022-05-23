#lang racket

;; iterative
(define (reverse l)
  (define (helper l result)
    (if (null? l)
        result
        (helper (cdr l) (cons (car l) result))))
  (helper l '()))

;; recursive
(define (reverser l)
  (if (null? l)
      l
      (append (reverser (cdr l)) (list (car l)))))

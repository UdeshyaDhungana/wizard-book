#lang racket

(require "../lib.rkt")

(define (id x) x)

(define (accumulate operation null-value term a next b)
  (define (helper a accumulator)
    (if (> a b)
        accumulator
        (helper (next a) (operation accumulator (term a)))))
  (helper a null-value))

(accumulate + 0 id 1 add1 10)
(accumulate * 1 id 1 add1 5)

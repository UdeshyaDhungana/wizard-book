#lang racket

(require "../lib.rkt")

(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
      null-value
      (combiner (if (filter a)
                    (term a)
                    null-value)
                (filtered-accumulate combiner null-value term (next a) next b filter))))


;Sum of squares from 0 to 10 which are odd --------------> Number a
(filtered-accumulate + 0 square 0 add1 10 prime?)

;; b
;; Product of all the positive integers less than n that are relatively prime to n

(define n 10)

(define (test x) 
  (and (> x 0) (< x n) (= (gcd x n) 1)))

(filtered-accumulate * 1 (lambda (x) x) 1 add1 n test)

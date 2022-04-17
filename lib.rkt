#lang racket

;; Some useful functions not available in default racket
(define (square x) (* x x))

(define (cube x) (* x x x))

;; Prime checking module
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
                n
                (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;; exports
(provide square)
(provide cube)
(provide divides?)
(provide prime?)

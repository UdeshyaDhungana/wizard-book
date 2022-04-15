#lang racket

(require "../lib.rkt")

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


(define (fermat-test n x)
    (= (expmod x n n) x))


(define (fermat-test-exhaustive n)
  (define (do-it x)
    (if (< x 1)
        1
        (and (fermat-test n x) (do-it (- x 1)))))
  (do-it (- n 1)))


(fermat-test-exhaustive 6601)
(fermat-test-exhaustive 2821)
(fermat-test-exhaustive 2465)
(fermat-test-exhaustive 1729)
(fermat-test-exhaustive 1105)
(fermat-test-exhaustive 561)

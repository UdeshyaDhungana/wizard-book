#lang racket


(require "../lib.rkt")

(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))

(define (divides a b)
  (= (remainder b a) 0))


(define (prime? n)
  (= (smallest-divisor n) n))


;; Fermat's test

(define (expmod base exponent m)
  (cond ((= exponent 0) 1)
        ((even? exponent)
         (remainder
          (sqr (expmod base (/ exponent 2) m))
                  m))
         (else (remainder
                (* base (expmod base (- exponent 1) m))
                m))))


(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  ;; not including 0, and including (- n 1)
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

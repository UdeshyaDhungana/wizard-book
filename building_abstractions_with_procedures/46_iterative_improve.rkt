#lang racket
;Iterative improve

(require "../lib.rkt")

(define (iterative-improve good-enough? improve)
  (letrec ((iterator (lambda (guess)
                       (if (good-enough? guess (improve guess))
                         guess
                         (iterator (improve guess))))))
    iterator))

(define tolerance 0.0001)


;Square root procedure in iterms of iterative-improve----------------


(define (mysqrt x)
  (define (good-enough?-sqrt guess improved-guess)
    (< (abs (- (sqr guess) x)) tolerance))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2.0))
  ((iterative-improve good-enough?-sqrt improve) 1.0))

(mysqrt 10)

;Fixed point using iterative-improve---------------------------------


(define (fixed-pt f first-guess)
  (define (good-enough? guess improved-guess)
    (< (abs (- guess improved-guess)) tolerance))
  (define (improve-fixed guess)
    (f guess))
  ((iterative-improve good-enough? improve-fixed) first-guess))

(fixed-pt cos 1.0)

#lang racket
;Smoothing a function

(require "./43_fn.rkt")

(define dx 0.0001)

(define (average x y z)
  (/ (+ x y z) 3))

(define (smooth f)
  (lambda (x)
    (average (f (- x dx)) (f x) (f (+ x dx)))))

;First I implemented this function as
; (repeated (smooth f) n)
; This was wrong because we should smooth a `smoothed function`
; This expression really captures the idea
(define (n-fold-smoothed f n)
  ((repeated smooth n) f))

#lang racket

;;;; Calculate cube root of a number

;; Absolute error less than 1% of original
(define (good-enuf? guess x)
  (< (/ (abs (- (expt guess 3) x)) x) 0.01))

(define (improve y x)
  (/ (+ (/ x (sqr y)) (* 2 y)) 3))

(define (cube-root-iter guess x)
  (if (good-enuf? guess x)
    guess
    (cube-root-iter (improve guess x) x)))

(cube-root-iter 2 27.0)

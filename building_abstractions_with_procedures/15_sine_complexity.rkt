#lang racket

(require racket/trace)

(define (p x) (- (* 3 x) (* 4 (expt x 3))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3)))))

(trace sine)
(sine 12.15) ;; sine is called 6 times
;; Complexity turns out to be log(n)

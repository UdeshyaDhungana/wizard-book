#lang racket
(require "../lib.rkt")

;Good enough can be adjusted to give true whenever the square of guess is
;absolutely less than 1% of true value


;New good-enough? function
(define (new-good-enuf? guess x)
  (< (/ (abs (- (square guess) x)) x) 0.01))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (new-good-enuf? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))


(sqrt-iter 5 36)

#lang racket

(require "../lib.rkt")


;; fixed point function
(define tolerance 0.0001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;; returns average of x and f(x)
(define (average-damp f)
  (lambda (x) (average x (f x))))

;; define sqrt
(define (sqrtt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (sqr y)))) 1.0))

;; Newton's method

(define dx 0.0001)
(define (derivative g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x)) dx)))

;; ((derivative (lambda (x) (* 2 (sqr x)))) 8)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((derivative g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;; abstractions
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (yasqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y)) average-damp 1.0))

;; What's really going on here is
;; x, f, transform, guess -> (fixed-point (transform f) guess)
;; we compute the fixed-point of a (transformed-function) on an initial guess.

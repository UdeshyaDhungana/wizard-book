#lang racket
;Compute nth root of a number

;Repeated procedure
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
    f
    (compose f (repeated f (- n 1)))))


(define (average x y)
  (/ (+ x y) 2.0))

;Average Damp
(define (average-damp f)
  (lambda (x) (average x (f x))))

;Fixed point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


;Task: Implement nth root using given 3 procedures

;x -> number whose nth root can be found
;n -> degree of root

;From what I've observed sqrt(n) average-damps are required for nth root
;Actually it turns out to be (log 2 n)
;Explanation:
;(repeated average-damp n) returns a procedure that is n composition of the function
;`average-damp`, now that procedure, i.e. n average-damps are applied to a function
;which is (x/y^n-1), effectively applying average damps n times
;
;
(define (nth-root x n)
  (fixed-point ((repeated average-damp (ceiling (sqrt n))) (lambda(y) (/ x (expt y (- n 1))))) 1.0))

(nth-root 32 5)
(nth-root 69420 7)

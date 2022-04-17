#lang racket
;Product using higher order procedure

(define (product term a next b)
  (if (> a b)
    1
    (* (term a) (product term (next a) next b))))

(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (identity x) x)

(define (factorial n)
  (product identity 1 inc n))


(factorial 5)

;Estimation of pi/4



(define (quarter-pi-estimate n)
  (define (get-numerator x)
    (if (= x 0)
        2
        (+ x 2)))
  ;; produces denominator given numerator and the parity of numerator's term
  (define (get-denominator numer is-even)
    (if is-even inc dec) numer)
  (define (pi-term x)
    (let ((numer (get-numerator x)))
      (/ (numer) (get-denominator numer (even? x)))))
  (define (next-term x) (+ x 1))
  (product pi-term 1 next-term n))


(quarter-pi-estimate 100)

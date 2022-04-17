#lang racket
;Estimating Euler's constant using `cont-frac`


(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))



(define (euler x)
  (define (int-div a b)
    (/ (- a (remainder a b)) b))
  (if (= (remainder x 3) 2)
      (+ 2 (* 2 (quotient x 3)))
      1))


(define (id x) 1.0)

;Estimating e-2
(+ 2 (cont-frac id euler 20))

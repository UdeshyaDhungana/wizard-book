#lang racket
;Estimating tan(r)

(require "../lib.rkt")

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))



(define (tan-cf r)
  (define (odd x)
    (- (* 2 x) 1))
  (define (tan-term x)
    (if (= x 1)
      r
      (* -1 (sqr r))))
  (cont-frac tan-term odd 20))


(tan-cf (/ (acos -1.0) 4.0))

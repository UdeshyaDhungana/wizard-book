#lang racket

;; Fast multiplication
;;
(define (double x) (* 2 x))
(define (halve x) (/ x 2))

(define (product a b)
    (cond
      ;; correct base condition
      ((or (= a 0) (= b 0)) 0)
      ((= a 1) b)
      ((even? a) (product (halve a) (double b)))
      (else (+ b (product (- a 1) b)))))


(product 3 0)
(product 255 256)

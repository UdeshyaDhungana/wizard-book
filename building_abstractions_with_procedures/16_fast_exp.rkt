#lang racket


;Fast exponentian
(define (fast-exponentian base exponent)
  (define (fexp b n a)
    (cond ((= n 0) a)
          ((even? n) (fexp (sqr b) (/ n 2) a))
          (else (fexp b (- n 1) (* a b)))))
  (fexp base exponent 1))

(fast-exponentian 3 5)

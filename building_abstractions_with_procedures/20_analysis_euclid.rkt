#lang racket

;; Normal order was too hefty -> Turns out it involves 20 remainder calls
;; Applicative order -> 4 calls

(require racket/trace)


(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(trace gcd)
(gcd 206 40) ;; yields 4 calls to remainder
